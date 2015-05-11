require 'set'

ActiveAdmin.register Tournament do

  menu :parent => "bPOP Tournaments"# , :priority => 1
  filter :title

  before_filter :only => [:update] do
    @tournament = Tournament.unscoped.friendly.find(params[:id])
    eps = Set.new((params[:tournament][:episode_ids].select {|s| s && s != ""}).map {|eid| Integer(eid)})
    unless eps == (Set.new @tournament.episodes.map(&:id))
      @tournament.start_date = params[:tournament][:start_date]
      @tournament.save
      @tournament.episodes = Episode.find(eps.to_a)
    end
    @tournament.reload
  end

  before_filter :only => [:show, :destroy, :edit, :update] do
    @tournament = Tournament.unscoped.friendly.find(params[:id])
  end

  form  do |f|
    f.inputs "Tournament Details" do
      f.input :title, :label => "Tournament Title", :required => true
      f.input :subtitle, :label => "Tournament Subtitle", :required => true
      f.input :start_date, required: true, as: :datetime_picker
      f.input :image,  :hint => f.object.image.present? \
        ? f.template.image_tag(f.object.image.url(:thumb))
      : f.template.content_tag(:span, 'Main show image.')
      f.input :background,  :hint => f.object.background.present? \
        ? f.template.image_tag(f.object.background.url(:thumb))
      : f.template.content_tag(:span, 'No background as yet.')
      f.input :description,  :label => "Description", :as => :rich, :allow_embeds => true
      f.input :episodes, :class => 'chosen', :as => :select, :required => true
    end

    f.inputs "Ads" do
      f.input :dfp_header_code, :label => "DFP Custom Header Code"
      f.input :dfp_banner_ad, :label => "DFP Banner Ad"
    end


    f.has_many :matches do |match|
      match.input :player_one, required: true
      match.input :player_two, required: true
      match.input :first_seat, required: true
      match.input :second_seat, required: true
      match.input :start, required: true, as: :datetime_picker
      match.input :finish, required: true, as: :datetime_picker
      match.input :billboard
    end

    f.actions
  end

  action_item only: :show do
    link_to('View on site', tournament)
  end

end
