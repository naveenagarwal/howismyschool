var colors = ['#AF0202', '#EC7A00', '#FCD200', '#81C714'];

function Charts(){
}

Charts.drawChart = function(url, container, xlabel, ylabel){
  var myChart = new JSChart(container, 'bar');
  myChart.setDataJSON(url);
  myChart.setAxisNameX(xlabel);
  myChart.setAxisNameY(ylabel, true);
  myChart.setAxisNameColor("#000000");
  myChart.setAxisValuesColor("#000000");
  myChart.setBarValuesColor("#000000");
  myChart.setBarValuesDecimals(2);
  myChart.colorizeBars(colors);
  myChart.draw();
  myChart.resize(500, 350)
}

Charts.drawLatestTestResultsChart = function(container){
  var url       = '/draw_chart/chart_for_latest_test_results.json?chart_type=bar',
      container = container,
      xlabel    = 'Tests',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel);
}

Charts.drawClassRoomChart = function(class_room, container){
  var url       = '/draw_chart/' + class_room + '/chart_for_class_room.json?chart_type=bar',
      container = container,
      xlabel    = 'Tests',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel);

}

Charts.drawClassRoomToppersSubjectwiseChart = function(class_room, container){
  var url       = '/draw_chart/' + class_room + '/chart_for_class_room_toppers_subjectwise.json?chart_type=bar',
      container = container,
      xlabel    = 'Student/Subejct/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel);

}

Charts.drawClassRoomToppersTestwiseChart = function(class_room, container){
  var url       = '/draw_chart/' + class_room + '/chart_for_class_room_toppers_testwise.json?chart_type=bar',
      container = container,
      xlabel    = 'Student/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel);
}

Charts.drawClassRoomLowestScorersTestwiseChart = function(class_room, container){
  var url       = '/draw_chart/' + class_room + '/chart_for_class_room_lowest_scorers_testwise.json?chart_type=bar',
      container = container,
      xlabel    = 'Student/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel);
}