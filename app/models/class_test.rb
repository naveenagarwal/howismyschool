class ClassTest < ActiveRecord::Base
  belongs_to :school
  belongs_to :school_branch
  belongs_to :creator, polymorphic: true
end
