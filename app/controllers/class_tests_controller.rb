class ClassTestsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_class_test, only: [:show, :edit, :update, :destroy]

  # GET /class_tests
  # GET /class_tests.json
  def index
    @class_tests = current_school_branch.class_tests.all
  end

  # GET /class_tests/1
  # GET /class_tests/1.json
  def show
  end

  # GET /class_tests/new
  def new
    @class_test = ClassTest.new
  end

  # GET /class_tests/1/edit
  def edit
  end

  # POST /class_tests
  # POST /class_tests.json
  def create
    @class_test = ClassTest.new(class_test_params)
    @class_test.school_branch = current_school_branch
    @class_test.creator = current_teacher || current_entity

    respond_to do |format|
      if @class_test.save
        format.html { redirect_to @class_test, notice: 'Class test was successfully created.' }
        format.json { render :show, status: :created, location: @class_test }
      else
        format.html { render :new }
        format.json { render json: @class_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /class_tests/1
  # PATCH/PUT /class_tests/1.json
  def update
    respond_to do |format|
      if @class_test.update(class_test_params)
        format.html { redirect_to @class_test, notice: 'Class test was successfully updated.' }
        format.json { render :show, status: :ok, location: @class_test }
      else
        format.html { render :edit }
        format.json { render json: @class_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_tests/1
  # DELETE /class_tests/1.json
  def destroy
    @class_test.destroy
    respond_to do |format|
      format.html { redirect_to class_tests_url, notice: 'Class test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_test
      @class_test = current_school_branch.class_tests.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def class_test_params
      params.require(:class_test).permit(:name)
    end
end
