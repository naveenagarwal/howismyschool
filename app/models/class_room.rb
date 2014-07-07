class ClassRoom < ActiveRecord::Base

  DEFAULT_LIMIT = 5

  belongs_to :creator, polymorphic: true
  belongs_to :school
  belongs_to :school_branch
  belongs_to :document

  has_many :test_results
  has_many :subjects
  has_many :class_tests
  has_many :students

  validates :name,
            presence: true,
            uniqueness: { scope: [ :school_id, :school_branch_id, :grade ], case_sensitive: false }

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

  def current_test_results
    test_results.where(year: TimeExt.current_year)
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
    class_test_ids = current_test_results.order("id").pluck(:class_test_id).uniq
    average_test_results = []

    class_test_ids.each do |class_test_id|
      test_result = current_test_results.select(
          "avg(percentage) as percent, student_id"
        ).where(
          class_test_id: class_test_id
        ).group("student_id").order("percent DESC").first

      class_test = ClassTest.find(class_test_id)

      average_test_results << {
            unit: " #{test_result.student.name}/#{class_test.name}",
            value:  test_result.percent
          }

    end

    average_test_results
  end

end
