class MyAccountsController < ApplicationController
  before_action :ensure_session_exists!

  def index
    @details = current_entity.my_detail
  end

  def edit
    @details = current_entity.my_detail || MyDetail.new
  end

  def update
    @details = current_entity.my_detail || current_entity.build_my_detail
    @details.school_branch_id = current_school_branch.id

    if @details.update(my_details_params)
      redirect_to my_account_path, notice: 'Details was successfully saved.'
    else
      render :edit
    end
  end

  def more_details
  end

  private

  def my_details_params
    params.require(:my_detail).permit(
        :first_name, :middle_name, :last_name, :phone, :emergency_contact,
        :address_temporary, :address_permamnent
      )
  end

end
