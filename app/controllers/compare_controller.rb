class CompareController < ApplicationController
  before_action :authenticate_teacher!

  def index
    def index
      @class_rooms_array  = get_class_rooms_array_for_select_option
      # @students_array     = get_students_array_for_select_option
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

  end
end
