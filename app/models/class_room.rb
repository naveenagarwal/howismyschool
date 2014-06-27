class ClassRoom < ActiveRecord::Base
  belongs_to :creator, polymorphic: true
  belongs_to :school
  belongs_to :school_branch

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
end
