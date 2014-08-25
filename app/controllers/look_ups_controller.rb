class LookUpsController < ApplicationController
  before_action :authenticate_teacher!

  def index
    @class_rooms_array  = get_class_rooms_array_for_select_option
    @students_array     = get_students_array_for_select_option
    @class_tests_array  = get_class_tests_array_for_select_option
    @subjects_array     = get_subjects_array_for_select_option
  end

  def class_room_students
    class_room = ClassRoom.find params[:class_room]
    @students_array = class_room.students.map { |p| [ p.name_with_rno, p.id ] }
  end

  def show
    chart_type = params[:chart_type] || DEFAULT_CHART_TYPE

    @look_up = LookUp.new(
        year: params[:year],
        class_room_id:  params[:class_room_id],
        student_id:     params[:student_id],
        subject_id:     params[:subject_id],
        class_test_id:  params[:class_test_id],
        chart_hash:     default_chart_hash(chart_type)
      )
  end

  def new
    @look_up = LookUp.new
  end

  def edit
  end

  def create
    @look_up = LookUp.new(look_up_params)

    respond_to do |format|
      if @look_up.save
        format.html { redirect_to @look_up, notice: 'Look up was successfully created.' }
        format.json { render :show, status: :created, location: @look_up }
      else
        format.html { render :new }
        format.json { render json: @look_up.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @look_up.update(look_up_params)
        format.html { redirect_to @look_up, notice: 'Look up was successfully updated.' }
        format.json { render :show, status: :ok, location: @look_up }
      else
        format.html { render :edit }
        format.json { render json: @look_up.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @look_up.destroy
    respond_to do |format|
      format.html { redirect_to look_ups_url, notice: 'Look up was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

end
