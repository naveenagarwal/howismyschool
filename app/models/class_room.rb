class ClassRoom < ActiveRecord::Base
  belongs_to :creator, polymorphic: true
  belongs_to :school
  belongs_to :school_branch

  has_many :students

  validates :name,
            presence: true,
            uniqueness: { scope: [ :school_id, :school_branch_id, :grade ], case_sensitive: false }

  def full_name
    "#{name}#{grade}"
  end
end
