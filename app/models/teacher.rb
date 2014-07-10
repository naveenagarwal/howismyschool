class Teacher < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :school_branch
  belongs_to :school
  belongs_to :creator, polymorphic: true

  has_many :subjects, as: :creator
  has_many :students, as: :creator
  has_many :test_results, as: :creator
  has_many :test_results_from_files, as: :creator
  has_many :documents, as: :creator
  has_many :searches, as: :searcher

  has_one :my_detail, as: :whoami

  def current_test_results
    test_results.where(year: TimeExt.current_year, school_branch_id: school_branch_id)
  end

  def class_rooms_list
    ClassRoom.where(id: current_distinct_class_room_ids).map(&:full_name)
  end

  def class_tests_list
    ClassTest.where(id: current_distinct_class_test_ids).map(&:name)
  end

  def current_test_results_count_test_and_subjectwise
    result, test_result = {}, nil

    current_distinct_class_room_ids.each do |class_room_id|
      current_distinct_class_test_ids.each do |class_test_id|
        current_distinct_subject_ids.each do |subject_id|
          test_result = current_test_results.where(
              class_room_id: class_room_id,
              class_test_id: class_test_id,
              subject_id: subject_id
            )
          result.deep_merge! add_result(test_result.first, test_result.count)
        end
      end
    end
    result
  end

  private

  def add_result(test_result, count)
    {
      "#{test_result.class_room_name}" => {
        "#{test_result.class_test_name}" => {
          "#{test_result.subject_name}" => count
        }
      }
    }
  end

  def current_distinct_class_room_ids
    @class_room_ids ||= current_test_results.select("distinct on(class_room_id) class_room_id").map(&:class_room_id)
  end

  def current_distinct_class_test_ids
    class_test_ids ||= current_test_results.select("distinct on(class_test_id) class_test_id").map(&:class_test_id)
  end

  def current_distinct_subject_ids
    subject_ids ||= current_test_results.select("distinct on(subject_id) subject_id").map(&:subject_id)
  end

end
