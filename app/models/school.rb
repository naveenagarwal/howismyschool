class School < ActiveRecord::Base

  # belongs_to :school_controller
  belongs_to :manager

  has_many :teachers
  has_many :school_branches

  before_create :create_school_branch
  # before_create :create_controller
  before_create :create_manager

  private

  # def create_controller
  #   self.school_controller = SchoolController.where(email: regestrar_details["email"]).first

  #   unless school_controller
  #     self.school_controller = SchoolController.create(email: regestrar_details["email"], password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD)
  #   end
  # end

  def create_manager
    self.manager = Manager.where(email: regestrar_details["email"]).first

    unless manager
      self.manager = Manager.create(email: regestrar_details["email"], password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD)
    end
  end

  def create_manager
    @school_branch = SchoolBranch.create(name: name)
    self.school_branches << @school_branch
  end

end
