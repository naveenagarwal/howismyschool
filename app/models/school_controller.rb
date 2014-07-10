class SchoolController < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :school_branch
  belongs_to :manager

  has_many :teachers, as: :creator

  has_one :my_detail, as: :whoami

end
