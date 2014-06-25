class ClassRoom < ActiveRecord::Base
  belongs_to :creator, polymorphic: true
  belongs_to :school
  belongs_to :school_branch
end
