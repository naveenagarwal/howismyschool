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

  private

  def current_year
    time = Time.now

    if time.month.betwwen? 4, 12
      "#{time.year}-#{time.year + 1}"
    else
      "#{time.year - 1}-#{time.year}"
    end
  end
end
