class TestResultsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_test_result, only: [:show, :edit, :update, :destroy]

  # GET /test_results
  # GET /test_results.json
  def index
  end

  # GET /test_results/1
  # GET /test_results/1.json
  def show
  end

  # GET /test_results/new
  def new
    @test_result = TestResult.new

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

  # GET /test_results/1/edit
  def edit
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
        format.js { set_flash_messages type: 'notice', message: 'Error in saving Test result' }
        format.html { render :new }
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
        format.json { render :show, status: :ok, location: @test_result }
      else
        format.html { render :edit }
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
      params.require(:test_result).permit(:percentage, :grade, :outcome, :remarks, :subject_id, :student_id, :class_test_id, :class_room_id)
    end
end
