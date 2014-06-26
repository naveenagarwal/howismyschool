class SchoolController < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :schools
  has_many :school_branches, through: :schools

  belongs_to :school_branch
  belongs_to :manager
end
