module Charts
  module BarChartForStudents

    def student_toppers
      @js_chart["JSChart"]["datasets"][0]["data"]  =
        @student.get_toppers_array_for_bar_chart

      respond_to do |format|
        format.json { render json: @js_chart }
      end
    end

    def student_lowest_scorers
      @js_chart["JSChart"]["datasets"][0]["data"]  =
        @student.get_lowest_scorers_array_for_bar_chart

      respond_to do |format|
        format.json { render json: @js_chart }
      end
    end

    def student_overall_performance
      @js_chart["JSChart"]["datasets"][0]["data"]  =
        @student.get_overall_array_for_bar_chart

      respond_to do |format|
        format.json { render json: @js_chart }
      end
    end

    def tests_score
      @student.tests_score_for_bar_chart.each.with_index do |data, index|
        @js_chart["JSChart"]["datasets"][index] ||= {}
        @js_chart["JSChart"]["datasets"][index]["type"] = @chart_type
        @js_chart["JSChart"]["datasets"][index]["data"] = data
      end

      respond_to do |format|
        format.json { render json: @js_chart }
      end
    end

    def subjects_score
      @student.subjects_score_for_bar_chart.each.with_index do |data, index|
        @js_chart["JSChart"]["datasets"][index] ||= {}
        @js_chart["JSChart"]["datasets"][index]["type"] = @chart_type
        @js_chart["JSChart"]["datasets"][index]["data"] = data
      end

      respond_to do |format|
        format.json { render json: @js_chart }
      end
    end

    def subjects_yearwise_score
      @student.subjects_score_yearwise_for_bar_chart.each.with_index do |data, index|
        @js_chart["JSChart"]["datasets"][index] ||= {}
        @js_chart["JSChart"]["datasets"][index]["type"] = @chart_type
        @js_chart["JSChart"]["datasets"][index]["data"] = data
      end

      respond_to do |format|
        format.json { render json: @js_chart }
      end
    end

    protected

    def set_common_chart_data_for_students_charts
      @chart_type = params[:chart_type] || DEFAULT_CHART_TYPE
      @js_chart  = default_chart_hash(@chart_type)
      @student   = Student.find params[:id]
    end

  end
end