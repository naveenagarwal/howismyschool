module TestResultsHelper

  def barchart_for_latest_test_results(container)
    "
      <script type='text/javascript'>
        Charts.drawLatestTestResultsChart('#{container}');
      </script>
    ".html_safe
  end

end
