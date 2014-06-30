module TestResultsHelper

  def barchart_for_latest_test_results
    "
      <script type='text/javascript'>
        var myChart = new JSChart('chartcontainer', 'bar');
        myChart.setDataJSON('/draw_chart/chart_for_latest_test_results.json?chart_type=bar');
        myChart.setAxisNameX('Tests');
        myChart.setAxisNameY('Percentage(%)', true);
        myChart.draw();
      </script>
    ".html_safe
  end

end
