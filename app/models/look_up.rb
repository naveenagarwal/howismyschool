class LookUp

  attr_accessor :class_room, :class_room, :student_ids, :subject_ids, :year,
    :chart_hash, :test_name, :class_test_ids

  AVGERAGE  = "avg"
  MINIMUM   = "avg"
  MAXIMUM   = "avg"

  def initialize(class_room_id: nil, student_id: nil, subject_id: nil, class_test_id: nil, year: nil, chart_hash: nil)
    @year           = TimeExt.current_year
    @chart_hash     = chart_hash
    @class_room     = ClassRoom.find class_room_id
    @student_ids    = student_id.blank? ? class_room.student_ids : [student_id]
    @class_test_ids = class_test_id.blank? ? class_room.distinct_class_test_ids.uniq : [class_test_id]
    @subject_ids    = subject_id.blank? ? class_room.distinct_subject_ids.uniq : [subject_id]
  end

  def class_room_average_test_result
    test_results
      .select("class_test_id, avg(percentage) as avg_percent, class_test_name")
      .group("class_test_id, class_test_name").map { |t|
        [ t.class_test_name, t.avg_percent ]
      }
  end

  def class_room_minimum_test_result
    test_results
      .select("class_test_id, min(percentage) as min_percent, class_test_name")
      .group("class_test_id, class_test_name").map { |t|
        [ t.class_test_name, t.min_percent ]
      }
  end

  def class_room_maximum_test_result
    test_results
      .select("class_test_id, max(percentage) as max_percent, class_test_name")
      .group("class_test_id, class_test_name").map { |t|
        [t.class_test_name, t.max_percent]
      }
  end

  def student_average_test_result
    @tests = []
    test_results
      .select("class_test_id, avg(percentage) as avg_percent, class_test_name")
      .where(student_id: student_ids)
      .group("class_test_id, class_test_name").map { |t|
        @tests << t.class_test_id
        [t.class_test_name, t.avg_percent]
      }
  end

  def student_individual_test_results
    student_average_test_result if @tests.blank?

    tests = []
    @tests.each.with_index do |test_id, index|
      tests[index] = {}
      tests[index][:test_result] = test_results
        .select("percentage, subject_name, class_test_name")
        .where(student_id: student_ids, class_test_id: test_id)
        .map { |t|
          @test_name = t.class_test_name
          [t.subject_name, t.percentage]
        }
      tests[index][:test_name] = test_name
    end
    tests
  end

  private

    def test_results
      TestResult.where(
          year: year,
          class_room_id: class_room.id,
          class_test_id: class_test_ids,
          subject_id: subject_ids
        )
    end

end