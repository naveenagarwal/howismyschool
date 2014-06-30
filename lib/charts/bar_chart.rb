require 'active_support/concern'

module Charts
  module BarChart
    extend ActiveSupport::Concern

    DEFAULT_CHART_TYPE = "bar"

    included do
    end

    module ClassMethods
    end

    def chart_for_latest_test_results
      chart_type = params[:chart_type] || DEFAULT_CHART_TYPE

      js_chart = default_chart_hash(chart_type)

      class_room = current_school_branch.test_results.last.class_room

      test_results = TestResult.where(class_room_id: class_room.id)
      class_test_ids = test_results.pluck(:class_test_id).uniq

      average_test_results = []

      class_test_ids.each do |class_test_id|
        test_result = test_results.where(class_test_id: class_test_id).select("avg(percentage) as percent, class_test_id").group("class_test_id").first

        average_test_results << {
            unit: test_result.class_test.name,
            value:  test_result.percent
          }
      end

      js_chart["JSChart"]["datasets"][0]["data"] = average_test_results

      respond_to do |format|
        format.json { render json: js_chart }
      end
    end


    private

    def default_chart_hash(chart_type)
      {
        "JSChart" => {
          "datasets" => [{
              "type" =>  chart_type
            }]
          }
      }
    end

  end
end