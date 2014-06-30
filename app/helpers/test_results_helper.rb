module TestResultsHelper

  def barchart_for_latest_test_results(container)
    "
      <script type='text/javascript'>
        var myChart = new JSChart('#{container}', 'bar');
        myChart.setDataJSON('/draw_chart/chart_for_latest_test_results.json?chart_type=bar');
        myChart.setAxisNameX('Tests');
        myChart.setAxisNameY('Percentage(%)', true);
        myChart.draw();
      </script>
    ".html_safe
  end

end
