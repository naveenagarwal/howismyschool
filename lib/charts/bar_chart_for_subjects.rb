module Charts
  module BarChartForSubjects

    def subject_toppers
      @js_chart["JSChart"]["datasets"][0]["data"]  =
        @subject.get_toppers_array_for_bar_chart

      respond_to do |format|
        format.json { render json: @js_chart }
      end
    end

    def subject_lowest_scorers
      @js_chart["JSChart"]["datasets"][0]["data"]  =
        @subject.get_lowest_scorers_array_for_bar_chart

      respond_to do |format|
        format.json { render json: @js_chart }
      end
    end

    protected

    def set_common_chart_data_for_subjects_charts
      chart_type = params[:chart_type] || DEFAULT_CHART_TYPE
      @js_chart   = default_chart_hash(chart_type)
      @subject = Subject.find params[:id]
    end

  end
end