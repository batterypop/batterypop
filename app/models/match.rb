class Match < ActiveRecord::Base
  belongs_to :player_one, class_name: Episode
  belongs_to :player_two, class_name: Episode
  belongs_to :tournament

  validates_inclusion_of :status,
    in: %w(scheduled active player_one_wins player_two_wins)

  accepts_nested_attributes_for :player_one
  accepts_nested_attributes_for :player_one

  has_attached_file :billboard,
  styles: {
    large: "1140x280#",
    thumb: "150x150#"
  },
  storage: :s3,
  s3_credentials: "#{Rails.root}/config/amazon_s3.yml",
  path: "images/:class/:id/:attachment/:style/:filename",
  bucket: S3_BUCKET,
  default_url: "/assets/missing.png"

  validates_attachment_content_type :billboard, :content_type => /\Aimage\/.*\Z/


  def votes episode
    TournamentVote.where(episode: episode, match: self).count
  end

  def advance! t
    status = self.status

    if status == "scheduled"
      result = advance_scheduled t
    end

    if status == "active"
      result = advance_active t
    end

    save if result
    result
  end

  def winner
    if self.status == "player_one_wins"
      self.player_one
    elsif self.status == "player_two_wins"
      self.player_two
    end
  end

  private

  def populate_parent_match
    raise "can't populate parent match for unfinished match" unless [
      "player_one_wins", "player_two_wins"
    ].include? self.status

    bkt = BracketTree::Bracket::SingleElimination.by_size self.tournament.episodes.count
    relation = BracketTree::PositionalRelation.new(bkt)

    match_winner_seat = self.status == "player_one_wins" ? self.first_seat : self.second_seat
    next_seat = (bkt.matches.select {|bm| bm.seats.include? match_winner_seat }).first.winner_to
    parent_match = (self.tournament.matches.where "first_seat = ? OR second_seat = ?", next_seat, next_seat).first

    if parent_match # no parent match means we are at root
      if parent_match.first_seat == next_seat
        parent_match.player_one = self.winner
      else
        parent_match.player_two = self.winner
      end
      parent_match.save
    end

  end

  def advance_scheduled t
    raise "Match state is scheduled but match finish date has already passed" if t > self.finish

    if t > self.start
      self.status = "active"
      self.save
    end

    self.status != "scheduled"
  end

  def advance_active t
    raise "Match state is active but match start date is not yet reached" if t < self.start

    if t > self.finish
      if self.votes(self.player_one) >= self.votes(self.player_two)
        self.status = "player_one_wins"
      else
        self.status = "player_two_wins"
      end

      populate_parent_match
    end

    self.status != "active"
  end
end
