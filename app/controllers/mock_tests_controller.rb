class MockTestsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_mock_test, only: [:show, :edit, :update, :destroy]

  # GET /mock_tests
  # GET /mock_tests.json
  def index
    @mock_tests = Paginate.get_records(
        relation_object: current_school_branch.mock_tests.includes(:class_room, :subject),
        page: params[:page],
        per_page: params[:per_page]
      )
  end

  # GET /mock_tests/1
  # GET /mock_tests/1.json
  def show
  end

  # GET /mock_tests/new
  def new
    @mock_test = MockTest.new
    @subjects_array = get_subjects_array
    @class_rooms_array = get_class_room_array
  end

  # GET /mock_tests/1/edit
  def edit
    @subjects_array = get_subjects_array
    @class_rooms_array = get_class_room_array
  end

  # POST /mock_tests
  # POST /mock_tests.json
  def create
    @mock_test = MockTest.new(mock_test_params)
    @mock_test.creator = current_teacher || current_entity
    @mock_test.school_branch = current_school_branch

    respond_to do |format|
      if @mock_test.save
        format.html { redirect_to @mock_test, notice: 'Mock test was successfully created.' }
        format.json { render :show, status: :created, location: @mock_test }
      else
        format.html {
          @subjects_array = get_subjects_array
          @class_rooms_array = get_class_room_array
          render :new
        }
        format.json { render json: @mock_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mock_tests/1
  # PATCH/PUT /mock_tests/1.json
  def update
    respond_to do |format|
      if @mock_test.update(mock_test_params)
        format.html { redirect_to @mock_test, notice: 'Mock test was successfully updated.' }
        format.json { render :show, status: :ok, location: @mock_test }
      else
        format.html {
          @class_rooms_array = get_class_room_array
          @subjects_array = get_subjects_array
          render :edit
        }
        format.json { render json: @mock_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mock_tests/1
  # DELETE /mock_tests/1.json
  def destroy
    @mock_test.destroy
    respond_to do |format|
      format.html { redirect_to mock_tests_url, notice: 'Mock test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mock_test
      @mock_test = current_school_branch.mock_tests.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mock_test_params
      params.require(:mock_test).permit(:subject_id, :publish, :name, :class_room_id)
    end

    def get_class_room_array
      ClassRoom.get_class_rooms_array_for_select_option(
          school_branch_id: current_school_branch.id
        )
    end

    def get_subjects_array
      Subject.get_subjects_array_for_select_option(
          school_branch_id: current_school_branch.id
        )
    end
end
