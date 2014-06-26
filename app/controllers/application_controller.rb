class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_session_nil?, :current_entity_type, :current_entity


  protected

  def enusre_manager
    if current_manager.blank?
      redirect_to entity_root_url, notice: "Unauthorized Access!"
    end
  end

  def ensure_school_controller
    if current_school_controller.blank?
      redirect_to entity_root_url, notice: "Unauthorized Access!"
    end
  end

  def current_school
    current_school_branch.try(:school)
  end

  def current_school_branch
    if session[:current_school_branch_id]
      branch = School.where(id: session[:current_school_branch_id]).first
    else
      if current_teacher
        branch = current_teacher.school_branch
      elsif current_controller_or_manager
        branch = current_entity.school_branches.first
      end
      session[:current_school_branch_id] = branch.id
    end
    branch
  end

  def current_controller_or_manager
    current_school_controller || current_manager
  end

  def current_session?
    current_entity
  end

  def current_entity
    current_teacher || current_school_controller || current_manager || current_admin_user
  end

  def current_session_nil?
    !current_session?
  end

  def current_entity_type
    session[:current_entity_type] ||= case
      when current_admin_user
        "admin"
      when current_teacher
        "teacher"
      when current_school_controller
        "school_controller"
      when current_manager
        "manager"
      else
        "guest"
      end
  end

  def after_sign_in_path_for(resource_or_scope)
    entity_root_url
  end

  def entity_root_url
    send("#{current_entity_type}s_root_url")
  end
end
