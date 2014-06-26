class Manager < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :schools
  has_many :school_branches, through: :schools
  has_many :school_controllers

end
