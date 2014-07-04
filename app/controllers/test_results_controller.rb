class TestResultsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_test_result, only: [:show, :update, :destroy]

  # GET /test_results
  # GET /test_results.json
  def index
    @class_room = current_school_branch.test_results.last.try(:class_room)
  end

  def list
    @test_results = Paginate.get_records(
        relation_object: current_school_branch.test_results.includes(:student, :subject, :class_test, :class_room),
        page: params[:page],
        per_page: params[:per_page]
      )
  end

  # GET /test_results/1
  # GET /test_results/1.json
  def show
  end

  # GET /test_results/new
  def new
    @test_result = TestResult.new
    get_arrays_for_select_options
  end

  # GET /test_results/1/edit
  def edit
    get_arrays_for_select_options
  end

  def for_edit
    respond_to do |format|
      format.html {
        set_test_result
        get_arrays_for_select_options
      }
      format.js {
        @test_result = TestResult.where(
            class_room_id:  params[:class_room_id],
            student_id:     params[:student_id],
            class_test_id:  params[:class_test_id],
            subject_id:     params[:subject_id]
          ).first

        if @test_result.blank?
          set_flash_messages type: 'error', message: 'Record Not Exist!'
        else
          get_arrays_for_select_options
        end
      }

    end

  end

  # POST /test_results
  # POST /test_results.json
  def create
    @test_result = TestResult.new(test_result_params)
    @test_result.school_branch = current_school_branch
    @test_result.creator = current_teacher || current_entity

    respond_to do |format|
      if @test_result.save
        format.html { redirect_to @test_result, notice: 'Test result was successfully created.' }
        format.js { set_flash_messages type: 'notice', message: 'Test result was successfully created.' }
        format.json { render :show, status: :created, location: @test_result }
      else
        format.html { render :new }
        format.js { set_flash_messages type: 'error', message: 'Error in saving Test result' }
        format.json { render json: @test_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_results/1
  # PATCH/PUT /test_results/1.json
  def update
    respond_to do |format|
      if @test_result.update(test_result_params)
        format.html { redirect_to @test_result, notice: 'Test result was successfully updated.' }
        format.js { set_flash_messages type: 'notice', message: 'Test result was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_result }
      else
        format.html { render :edit }
        format.js { set_flash_messages type: 'error', message: 'Error in saving Test result' }
        format.json { render json: @test_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_results/1
  # DELETE /test_results/1.json
  def destroy
    @test_result.destroy
    respond_to do |format|
      format.html { redirect_to test_results_url, notice: 'Test result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_result
      @test_result = current_school_branch.test_results.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_result_params
      params.require(:test_result).permit(:percentage, :grade, :outcome, :remarks, :subject_id, :student_id, :class_test_id, :class_room_id, :year)
    end

    def get_arrays_for_select_options
      @class_rooms_array = ClassRoom.get_class_rooms_array_for_select_option(
            school_branch_id: current_school_branch.id
          )

      @students_array = Student.get_students_array_for_select_option(
            school_branch_id: current_school_branch.id
          )

      @class_tests_array = ClassTest.get_class_tests_array_for_select_option(
            school_branch_id: current_school_branch.id
          )

      @subjects_array = Subject.get_subjects_array_for_select_option(
            school_branch_id: current_school_branch.id
          )
    end

end
