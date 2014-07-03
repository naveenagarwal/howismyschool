class TestResultsFromFile < ActiveRecord::Base
  mount_uploader :name, TestResultUploader

  serialize :parsing_errors, Array

  has_many :test_results, dependent: :destroy

  STATUS = {
    error_parsing:  1,
    complete:       2
  }

  belongs_to :school_branch
  belongs_to :creator, polymorphic: true

  validates :name, presence: { message: "~Document can't be left blank" }

  def status_name
    TestResultsFromFile::STATUS.each { | k, v | return k.to_s.titleize if status == v }
    nil
  end

  def errors_html
    parsing_errors.map do |error|
      "Row number: #{error.keys.first.to_s}<br />\
      Error(s): #{errors_from_hash(error.values.first)}"
    end.join("<br /><br />")
  end

  def all_test_results
    test_results.includes(:class_room, :class_test, :subject, :student)
  end

  def test_results_ids_attribute
    read_attribute(:test_result_ids)
  end

  private

  def errors_from_hash(errors)
    errors.map do |k, v|
      "<br/>#{k.to_s} : #{v.first}"
    end.join("")
  end

end
