class Teacher < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :school_branch
  belongs_to :school
  belongs_to :creator, polymorphic: true

  has_many :subjects, as: :creator
  has_many :students, as: :creator
end
