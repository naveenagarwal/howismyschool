class ClassTest < ActiveRecord::Base

  DEFAULT_CHART_LIMIT = 3

  belongs_to :school
  belongs_to :school_branch
  belongs_to :creator, polymorphic: true
  belongs_to :document

  has_many :test_results, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :school_branch_id }

  class << self
    def get_class_tests_array_for_select_option(school_branch_id: nil)
      select(:id, :name).
      where(
          school_branch_id: school_branch_id
        ).
      map { |p| [ p.name, p.id ] }
    end
  end

  def current_test_results
    test_results.where(year: TimeExt.current_year, school_branch_id: school_branch_id)
  end

  def has_test_results_for_current_year?
    current_test_results.count > 0
  end

  def get_toppers_array_for_bar_chart
    get_array_for_bar_chart(order: "DESC")
  end

  def get_lowest_scorers_array_for_bar_chart
    get_array_for_bar_chart(order: "ASC")
  end

  def get_subjectwise_toppers_array_for_bar_chart
    get_subject_array_for_bar_chart(order: "DESC", aggregate_method: "max")
  end

  def get_subjectwise_lowest_scorers_array_for_bar_chart
    get_subject_array_for_bar_chart(order: "ASC", aggregate_method: "min")
  end

  private

  def get_subject_array_for_bar_chart(order: nil, aggregate_method: nil)
    test_results   = []

    results = current_test_results.includes(:subject).select(
        "#{aggregate_method}(percentage) as percentage, subject_id, class_room_id"
      ).group(
        "subject_id, class_room_id"
      ).order("percentage #{order}").limit(ClassTest::DEFAULT_CHART_LIMIT + 2)

    results.each do |test_result|
      test_results << {
          unit: " #{test_result.subject.name}/#{test_result.class_room.full_name}/#{name}",
          value:  test_result.percentage
        }
    end
    test_results
  end

  def get_array_for_bar_chart(order: nil)
    test_results   = []

    results = current_test_results.includes(:class_room).select(
        "avg(percentage) as percent, class_room_id"
      ).group(
        "class_room_id"
      ).order("percent #{order}").limit(ClassTest::DEFAULT_CHART_LIMIT)

    results.each do |test_result|
      test_results << {
          unit: " #{test_result.class_room.full_name}/#{name}",
          value:  test_result.percent
        }
    end
    test_results
  end

end
