# == Schema Information
#
# Table name: survey_questions
#
#  id         :integer          not null, primary key
#  survey_id  :integer
#  text       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Survey::Question < ActiveRecord::Base

  self.table_name = "survey_questions"
  # relations
  has_many   :options
  belongs_to :survey
  accepts_nested_attributes_for :options,
    :reject_if => ->(a) { a[:text].blank? },
      :allow_destroy => true

  # attributes access permission
  # attr_accessible :options_attributes, :text, :survey

  # validations
  validates :text, :presence => true,
    :allow_blank => false

  def correct_options
    options.correct
  end

  def incorrect_options
    options.incorrect
  end
  
  def question_params
    params.require(:question).permit( :options_attributes, :text, :survey)
  end
end
