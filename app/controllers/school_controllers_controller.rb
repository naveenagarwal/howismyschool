class SchoolControllersController < ApplicationController
  before_action :enusre_manager
  before_action :set_school_controller, only: [:show, :edit, :update, :destroy]

  # GET /school_controllers
  # GET /school_controllers.json
  def index
    @school_controllers = Paginate.get_records(
        relation_object: current_manager.school_controllers.includes(:school_branch),
        page: params[:page],
        per_page: params[:per_page]
      )
  end

  # GET /school_controllers/1
  # GET /school_controllers/1.json
  def show
  end

  # GET /school_controllers/new
  def new
    @school_controller = SchoolController.new
  end

  # GET /school_controllers/1/edit
  def edit
  end

  # POST /school_controllers
  # POST /school_controllers.json
  def create
    @school_controller = SchoolController.new(school_controller_params)
    @school_controller.manager = current_manager

    respond_to do |format|
      if @school_controller.save
        format.html { redirect_to @school_controller, notice: 'School controller was successfully created.' }
        format.json { render :show, status: :created, location: @school_controller }
      else
        format.html { render :new }
        format.json { render json: @school_controller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /school_controllers/1
  # PATCH/PUT /school_controllers/1.json
  def update
    respond_to do |format|
      if @school_controller.update(school_controller_params)
        format.html { redirect_to @school_controller, notice: 'School controller was successfully updated.' }
        format.json { render :show, status: :ok, location: @school_controller }
      else
        format.html { render :edit }
        format.json { render json: @school_controller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /school_controllers/1
  # DELETE /school_controllers/1.json
  def destroy
    @school_controller.destroy
    respond_to do |format|
      format.html { redirect_to school_controllers_url, notice: 'School controller was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school_controller
      @school_controller = current_manager.school_controllers.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_controller_params
      params.require(:school_controller).permit(:email, :password, :password_confirmation, :school_branch_id)
    end
end
