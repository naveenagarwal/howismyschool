class TestResultsFromFile < ActiveRecord::Base
  mount_uploader :name, TestResultUploader

  serialize :parsing_errors, Array

  has_many :test_results

  STATUS = {
    error_parsing:  2,
    complete:       3
  }

  belongs_to :school_branch
  belongs_to :creator, polymorphic: true

  validates :name, presence: { message: "~Document can't be left blank" }

  def status_name
    "Set Status"
  end

  def status_message
    "Set status message"
  end

end
