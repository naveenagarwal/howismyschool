var colors = ['#AF0202', '#EC7A00', '#FCD200', '#81C714'];

function Charts(){
}

Charts.drawLatestTestResultsChart = function(container){
  var myChart = new JSChart(container, 'bar');
  myChart.setDataJSON('/draw_chart/chart_for_latest_test_results.json?chart_type=bar');
  myChart.setAxisNameX('Tests');
  myChart.setAxisNameY('Percentage(%)', true);
  myChart.colorizeBars([ colors[0], colors[1] ]);
  myChart.setFontFamily('"Comic Sans MS", cursive, sans-serif');
  myChart.setLabelFontFamily('"Comic Sans MS", cursive, sans-serif');
  myChart.draw();
}