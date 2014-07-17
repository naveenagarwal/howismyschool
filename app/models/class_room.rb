class ClassRoom < ActiveRecord::Base

  DEFAULT_LIMIT = 5

  belongs_to :creator, polymorphic: true
  belongs_to :school
  belongs_to :school_branch
  belongs_to :document

  has_many :test_results, dependent: :destroy
  has_many :class_room_students, dependent: :destroy
  has_many :students, through: :class_room_students

  validates :name,
            presence: true,
            uniqueness: { scope: [ :school_id, :school_branch_id, :grade ], case_sensitive: false }

  before_update :update_test_results

  searchable do
    text :full_name
    integer :school_branch_id
  end

  class << self
    def get_class_rooms_array_for_select_option(school_branch_id: nil)
      select(:id, :name, :grade).
      where(
          school_branch_id: school_branch_id
        ).
      map { |p| [ p.full_name, p.id ] }
    end
  end

  def full_name
    "#{name}#{grade}"
  end

  def current_students
    students.where(year: TimeExt.current_year)
  end

  def students_for_year(year)
    students.where(year: year)
  end

  def current_test_results
    test_results.where(year: TimeExt.current_year, school_branch_id: school_branch_id)
  end

  def has_test_results_for_current_year?
    test_results.where(year: TimeExt.current_year).count > 0
  end

  def get_toppers_array_subjectwise_for_bar_chart
    class_test_ids = current_test_results.order("id").pluck(:class_test_id).uniq
    average_test_results = []

    class_test_ids.each do |class_test_id|
      test_result = current_test_results.where(
          class_test_id: class_test_id
        ).order("percentage DESC").first

      average_test_results << {
            unit: " #{test_result.student.name}/#{test_result.subject.name}/#{test_result.class_test.name}",
            value:  test_result.percentage
          }

    end

    average_test_results
  end

  def get_toppers_array_testwise_for_bar_chart
    testwise_array_for_bar_chart(order: "DESC")
  end

  def get_lowest_scorers_array_testwise_for_bar_chart
    testwise_array_for_bar_chart(order: "ASC")
  end

  def latest_test_result
    current_test_results.order("created_at DESC").first
  end

  def students_with_test_results(outcome)
    as_name = (outcome == true ? "passed" : "failed")

    current_test_results.select(
        "distinct on(class_test_id) class_test_id, count(student_id) as #{as_name}, class_test_name"
      ).where(
        outcome: outcome
      ).group("class_test_name, class_test_id")
  end

  def get_pass_fail_tests_details_for_pie_chart(class_test_id)
    pass_fail_result = []

    [PASSED, FAILED].each do |outcome|
      as_name = (outcome == true ? "passed" : "failed")
      test_result = current_test_results.select(
              "class_test_id, count(student_id) as #{as_name}, class_test_name"
            ).where(
              outcome: outcome, class_test_id: class_test_id
            ).group("class_test_name, class_test_id").first

      pass_fail_result << {
          unit: (outcome == true ? "#{test_result.class_test_name} Passed" : "#{test_result.class_test_name} Failed" ),
          value: test_result.respond_to?(:passed) ? test_result.passed : test_result.failed
        }
    end
    pass_fail_result
  end

  def current_test_results_class_tests
    current_test_results.select(
        "distinct on(class_test_id) class_test_id, class_test_name"
      ).group("class_test_name, class_test_id")
  end

  private

  def testwise_array_for_bar_chart(order: "DESC")
    class_test_ids        = current_test_results.order("id").pluck(:class_test_id).uniq
    average_test_results  = []

    class_test_ids.each do |class_test_id|
      test_result = current_test_results.select(
          "avg(percentage) as percent, student_id"
        ).where(
          class_test_id: class_test_id
        ).group("student_id").order("percent #{order}").first

      class_test = ClassTest.find(class_test_id)

      average_test_results << {
            unit: " #{test_result.student.name}/#{class_test.name}",
            value:  test_result.percent
          }

    end

    average_test_results
  end

  def update_test_results
    test_results.update_all(class_room_name: full_name)  if (changes.keys & ["name", "garde"]).present?
  end

end
