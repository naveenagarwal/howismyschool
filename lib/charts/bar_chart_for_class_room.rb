module Charts
  module BarChartForClassRoom

    def chart_for_class_room
      chart_type                                  = params[:chart_type] || DEFAULT_CHART_TYPE
      js_chart                                    = default_chart_hash(chart_type)
      class_room                                  = ClassRoom.find params[:id]
      js_chart["JSChart"]["datasets"][0]["data"]  = test_results_for_class_room(class_room)

      respond_to do |format|
        format.json { render json: js_chart }
      end
    end

    def chart_for_class_room_toppers_subjectwise
      @js_chart["JSChart"]["datasets"][0]["data"]  =
        @class_room.get_toppers_array_subjectwise_for_bar_chart

      respond_to do |format|
        format.json { render json: @js_chart }
      end
    end

    def chart_for_class_room_toppers_testwise
      @js_chart["JSChart"]["datasets"][0]["data"]  =
        @class_room.get_toppers_array_testwise_for_bar_chart

      respond_to do |format|
        format.json { render json: @js_chart }
      end
    end

    def chart_for_class_room_lowest_scorers_testwise
      @js_chart["JSChart"]["datasets"][0]["data"]  =
        @class_room.get_lowest_scorers_array_testwise_for_bar_chart

      respond_to do |format|
        format.json { render json: @js_chart }
      end
    end

    def class_room_tests_pass_fail_details
      @js_chart["JSChart"]["datasets"][0]["data"]  =
        @class_room.get_pass_fail_tests_details_for_pie_chart(params[:class_test_id])

      respond_to do |format|
        format.json { render json: @js_chart }
      end
    end

    def class_test_full_test_result
      @js_chart["JSChart"]["datasets"][0]["data"]  =
        @class_room.class_test_full_test_result(
            class_test_id: params[:class_test_id],
            year: TimeExt.current_year
          )

      respond_to do |format|
        format.json { render json: @js_chart }
      end
    end

    protected

    def set_common_chart_data_for_class_room_charts
      chart_type = params[:chart_type] || DEFAULT_CHART_TYPE
      @js_chart   = default_chart_hash(chart_type)
      @class_room = ClassRoom.find params[:id]
    end

  end
end