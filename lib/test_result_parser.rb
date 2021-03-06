require 'roo'

class TestResultParser

  PARSE_BEGIN_STATUS_MESSSAGE = "Started reading test result"
  PARSE_SUCCESSFULL_STATUS_MESSSAGE = "Successfully fed test result into the system"
  PARSE_PARTIAL_SUCCESSFULL_STATUS_MESSSAGE = "Partial test results fed into the system due to errors in the document."
  PARSE_COMPLETE_WITH_NO_RECORDS = "No test result added from the document"

  attr_accessor :parser, :filepath, :errors, :status_message, :test_result_ids

  def initialize(filepath, parse_with, school_branch_id)
    @parser             = parse_with        || raise("filepath argument required")
    @filepath           = filepath          || raise("parse_with argument required")
    @school_branch_id   = school_branch_id  || raise("school_branch_id argument required")
    @status_message     = PARSE_BEGIN_STATUS_MESSSAGE

    @test_result_ids    = []
    @errors             = []
    @class_room_ids     = {}
    @subject_ids        = {}
    @student_ids        = {}
    @class_test_ids     = {}
  end

  class << self
    def parse(test_results_from_file: nil, parse_with: nil, school_branch_id: nil)
      raise "test_results_from_file argument required" if test_results_from_file.blank?

      filepath            = Rails.root.to_s + "/public" + test_results_from_file.name.to_s
      test_result_parser  = new(filepath, parse_with, school_branch_id)

      test_result_parser.parse(test_results_from_file)
    end
  end

  def parse(test_results_from_file)
    @test_results_from_file = test_results_from_file

    send("parse_#{file_extention}")

    @test_results_from_file.update(
      status_msg: @status_message,
      status: @errors.blank? ? TestResultsFromFile::STATUS[:complete] : TestResultsFromFile::STATUS[:error_parsing],
      parsing_errors: @errors,
      test_result_ids: @test_result_ids
    )
  end

  private

  def file_extention
    filepath.split(".").last.downcase
  end

  def parse_csv
    @document = parser.new(filepath, csv_options: { headers: true } )

    @document.each_with_index do |row, index|
      create_test_result_with(row.to_h, index + 2)
    end
    set_status
  end

  def parse_xls
    "yet to be implemented"
  end

  def parse_xlsx
    "yet to be implemented"
  end

  def create_test_result_with(row, index)
    attributes = {
      school_branch_id:           @school_branch_id,
      class_room_id:              get_class_room_id(row),
      student_id:                 get_student_id(row),
      class_test_id:              get_class_test_id(row),
      subject_id:                 get_subject_id(row),
      percentage:                 row["percentage"],
      outcome:                    row["outcome"].downcase == "pass" ? true : false,
      year:                       row["year"],
      remarks:                    row["remarks"],
      grade:                      row["grade"],
      creator_id:                 @test_results_from_file.creator_id,
      creator_type:               @test_results_from_file.creator_type,
      test_results_from_file_id:  @test_results_from_file.id
    }

    test_result = TestResult.new attributes

    if test_result.valid? && test_result.save
      @test_result_ids << test_result.id
    else
      @errors << { "#{index}" => test_result.errors.messages }
    end
  end

  def get_class_room_id(row)
    @class_room_ids["#{@school_branch_id}-#{row["class_room"]}-#{row["section"]}"] ||= {}

    if @class_room_ids["#{@school_branch_id}-#{row["class_room"]}-#{row["section"]}"]["is_set"]
      @class_room_ids["#{@school_branch_id}-#{row["class_room"]}-#{row["section"]}"]["id"]
    else
      @class_room_ids["#{@school_branch_id}-#{row["class_room"]}-#{row["section"]}"]["is_set"] = true

      @class_room_ids["#{@school_branch_id}-#{row["class_room"]}-#{row["section"]}"]["id"] =
          ClassRoom.where(:school_branch_id => @school_branch_id).where([
          "
            LOWER(name)   = LOWER(?) AND \
            LOWER(grade)  = LOWER(?) \
          ", row["class_room"].to_s, row["section"].to_s
        ]).first.try(:id)
    end

  end

  def get_student_id(row)
    @student_ids["#{@school_branch_id}-#{row["class_room"] + row["section"]}-#{row["student_name"]}-#{row["roll_no"]}"] ||= {}

    if @student_ids["#{@school_branch_id}-#{row["class_room"] + row["section"]}-#{row["student_name"]}-#{row["roll_no"]}"]["is_set"]
      @student_ids["#{@school_branch_id}-#{row["class_room"] + row["section"]}-#{row["student_name"]}-#{row["roll_no"]}"]["id"]
    else
      @student_ids["#{@school_branch_id}-#{row["class_room"] + row["section"]}-#{row["student_name"]}-#{row["roll_no"]}"]["is_set"] = true
      @student_ids["#{@school_branch_id}-#{row["class_room"] + row["section"]}-#{row["student_name"]}-#{row["roll_no"]}"]["id"] =
        Student.where(:school_branch_id => @school_branch_id).where([
          "
            LOWER(name)   = LOWER(?) AND \
            LOWER(roll_number)  = LOWER(?) AND\
            LOWER(year) = LOWER(?) AND\
            class_room_id = ?
          ", row["student_name"].to_s, row["roll_no"].to_s, row["year"], get_class_room_id(row)
        ]).first.try(:id)
    end
  end

  def get_class_test_id(row)
    @class_test_ids["#{@school_branch_id}-#{row["test_name"]}"] ||= {}

    if @class_test_ids["#{@school_branch_id}-#{row["test_name"]}"]["is_set"]
      @class_test_ids["#{@school_branch_id}-#{row["test_name"]}"]["id"]
    else
      @class_test_ids["#{@school_branch_id}-#{row["test_name"]}"]["is_set"] = true
      @class_test_ids["#{@school_branch_id}-#{row["test_name"]}"]["id"] =
        ClassTest.where(:school_branch_id => @school_branch_id).where([
            "
              LOWER(name)   = LOWER(?) \
            ", row["test_name"].to_s
          ]).first.try(:id)
    end
  end

  def get_subject_id(row)
    @subject_ids["#{@school_branch_id}-#{row["subject"]}"] ||= {}

    if @subject_ids["#{@school_branch_id}-#{row["subject"]}"]["is_set"]
      @subject_ids["#{@school_branch_id}-#{row["subject"]}"]["id"]
    else
      @subject_ids["#{@school_branch_id}-#{row["subject"]}"]["is_set"] = true
      @subject_ids["#{@school_branch_id}-#{row["subject"]}"]["id"] =
        Subject.where(:school_branch_id => @school_branch_id).where([
            "
              LOWER(name)   = LOWER(?) \
            ", row["subject"].to_s
          ]).first.try(:id)
    end
  end

  def set_status
    if @errors.blank?
      @status_message = PARSE_SUCCESSFULL_STATUS_MESSSAGE
    elsif @errors.present? && @test_result_ids.present?
      @status_message = PARSE_PARTIAL_SUCCESSFULL_STATUS_MESSSAGE
    elsif @errors.present? && @test_result_ids.blank?
      @status_message = PARSE_COMPLETE_WITH_NO_RECORDS
    end
  end

end