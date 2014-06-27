class Subject < ActiveRecord::Base
  belongs_to :school_branch
  belongs_to :creator, polymorphic: true
end
