class Teachers::HomeController < ApplicationController
  before_action :authenticate_teacher!

  def index
    if @show_charts = current_teacher.test_results.exists?
      @class_room = current_teacher.test_results.last.class_room
      @class_test = current_teacher.test_results.last.class_test
      @subject = current_teacher.test_results.last.subject
      @student = current_teacher.test_results.last.student
    end
  end

end
