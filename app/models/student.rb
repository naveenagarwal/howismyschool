class Student < ActiveRecord::Base
  belongs_to :creator, polymorphic: true
  belongs_to :school_branch
  belongs_to :class_room
  belongs_to :document

  has_many :test_results, dependent: :destroy
  has_many :class_room_students, dependent: :destroy


  validates :name, :roll_number, :class_room_id, :year, presence: true
  validates :name,
    uniqueness: {
      scope: [ :class_room_id, :roll_number, :school_branch_id ],
      message: " - This student already exists with same name and roll number"
    }

  before_update :update_test_results

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

  def tests_score_for_bar_chart
    ids = current_test_results.select("distinct on(class_test_id) class_test_id").map(&:class_test_id)
    scores_for_extended_bar_charts(ids, "class_test_id")
  end


  def subjects_score_for_bar_chart
    ids = current_test_results.select("distinct on(subject_id) subject_id").map(&:subject_id)
    scores_for_extended_bar_charts(ids, "subject_id")
  end

  def subjects_score_yearwise_for_bar_chart
    ids = test_results.select(
        "distinct on(subject_id) subject_id"
      ).where(
        school_branch_id: school_branch_id
      ).map(&:subject_id)

    scores_for_extended_yearly_bar_charts(ids, "subject_id")
  end

  def create_class_room_student
    ClassRoomStudent.create(
        student_id: id,
        class_room_id: class_room_id,
        school_branch_id: school_branch_id,
        creator_id: creator_id,
        creator_type: creator_type,
        year: year
      )
  end

  def current_class_room
    class_room_students.where(year: TimeExt.current_year).first.class_room
  end

  private

  def scores_for_extended_yearly_bar_charts(ids, associated_attribute)
    test_results_array = []

    ids.each.with_index do |score_id, index|
      test_results_array[index] ||= []

      results = test_results.select(
          "percentage, subject_name, class_test_name, class_room_name, year"
        ).where("#{associated_attribute}" => score_id).order("year asc")

      results.each do |test_result|
        test_results_array[index] << [
            "#{test_result.subject_name}/#{test_result.class_test_name}/#{test_result.class_room_name}/#{test_result.year}",
            test_result.percentage
          ]
      end
    end
    test_results_array
  end

  def scores_for_extended_bar_charts(ids, associated_attribute)
    test_results_array = []

    ids.each.with_index do |score_id, index|
      test_results_array[index] ||= []

      results = current_test_results.select(
          "percentage, subject_name, class_test_name, class_room_name"
        ).where("#{associated_attribute}" => score_id)

      results.each do |test_result|
        test_results_array[index] << [
            "#{test_result.subject_name}/#{test_result.class_test_name}/#{test_result.class_room_name}",
            test_result.percentage
          ]
      end
    end
    test_results_array
  end

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

  def update_test_results
    test_results.update_all(student_name: name_with_rno)  if (changes.keys & ["name", "roll_number"]).present?
  end

end
