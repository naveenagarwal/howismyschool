class Student < ActiveRecord::Base
  belongs_to :creator, polymorphic: true
  belongs_to :school_branch
  belongs_to :class_room
  belongs_to :document

  has_many :test_results, dependent: :destroy

  validates :name, :roll_number, :class_room_id, :year, presence: true
  validates :name,
    uniqueness: {
      scope: [ :class_room_id, :roll_number, :school_branch_id, :year ],
      message: " - This student already exists with same name and roll number"
    }


  searchable do
    text :name
    integer :school_branch_id
  end

  class << self
    def get_students_array_for_select_option(school_branch_id: nil)
      select(:id, :name, :roll_number).
      where(
          school_branch_id: school_branch_id
        ).
      map { |p| [ p.name_with_rno, p.id ] }
    end
  end

  def name_with_rno
    "#{name.titleize} - #{roll_number}"
  end

  def current_test_results
    test_results.where(year: TimeExt.current_year, school_branch_id: school_branch_id)
  end

  def has_test_results_for_current_year?
    current_test_results.count > 0
  end

  def get_toppers_array_for_bar_chart
    get_array_for_bar_chart(aggregate_method: "max", order: "DESC")
  end

  def get_lowest_scorers_array_for_bar_chart
    get_array_for_bar_chart(aggregate_method: "min", order: "ASC")
  end

  def get_overall_array_for_bar_chart
    get_overall_array
  end

  private

  def get_array_for_bar_chart(aggregate_method: "max", order: "DESC")
    test_results_array = []

    results = current_test_results.includes(:subject).select(
        "#{aggregate_method}(percentage) as percentage, subject_id, class_test_id"
      ).group(
        "subject_id, class_test_id"
      ).order("percentage #{order}").limit(DEFAULT_CHART_LIMIT + 2)

    results.each do |test_result|
      test_results_array << {
          unit: " #{test_result.subject.name}/#{test_result.class_test.name}",
          value:  test_result.percentage
        }
    end
    test_results_array
  end

  def get_overall_array
    test_results_array = []

    results = current_test_results.includes(:class_test).select(
        "avg(percentage) as percentage, class_test_id"
      ).group(
        "class_test_id"
      ).order("class_test_id ASC").limit(DEFAULT_CHART_LIMIT + 2)

    results.each do |test_result|
      test_results_array << {
          unit: "#{test_result.class_test.name}",
          value:  test_result.percentage
        }
    end
    test_results_array
  end

end
