class ClassRoom < ActiveRecord::Base
  belongs_to :creator, polymorphic: true
  belongs_to :school
  belongs_to :school_branch

  validates :name,
            presence: true,
            uniqueness: { scope: [ :school_id, :school_branch_id, :grade ], case_sensitive: false }

end
