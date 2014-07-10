class MyDetail < ActiveRecord::Base
  belongs_to :whoami, polymorphic: true
  belongs_to :school_branch

  validates :first_name, :phone, :emergency_contact, presence: true
end
