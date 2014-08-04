class MockTest < ActiveRecord::Base
  belongs_to :school_branch
  belongs_to :creator, polymorphic: true
  belongs_to :class_room
  belongs_to :subject

  has_many :ques_and_ans, class_name: "QuesAndAns", dependent: :destroy

  validates :name, :subject_id, :class_room_id, presence: true
end
