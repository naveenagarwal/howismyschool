class MockTest < ActiveRecord::Base
  belongs_to :school_branch
  belongs_to :creator, polymorphic: true
  belongs_to :class_room

  validates :name, presence: true
end
