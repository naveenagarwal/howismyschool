var colors = new Array('#AF0202', '#EC7A00', '#FCD200', '#81C714', '#0F0F0F', '#F77777');

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

  var newClorsArray = [];
  for(var i=0; i<myChart.ml.bi.length; i++){
    newClorsArray.push(colors[i]);
  }

  myChart.colorizeBars(newClorsArray);
  // console.log(myChart.ml.bi.length);
  myChart.draw();
  myChart.resize(500, 350)
  return myChart;
};

Charts.drawLatestTestResultsChart = function(container){
  var url       = '/draw_chart/chart_for_latest_test_results.json?chart_type=bar',
      container = container,
      xlabel    = 'Tests',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel);
};

Charts.drawClassRoomChart = function(class_room, container){
  var url       = '/draw_chart/' + class_room + '/chart_for_class_room.json?chart_type=bar',
      container = container,
      xlabel    = 'Tests',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel);
};

Charts.drawClassRoomToppersSubjectwiseChart = function(class_room, container){
  var url       = '/draw_chart/' + class_room + '/chart_for_class_room_toppers_subjectwise.json?chart_type=bar',
      container = container,
      xlabel    = 'Student/Subejct/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel);
};

Charts.drawClassRoomToppersTestwiseChart = function(class_room, container){
  var url       = '/draw_chart/' + class_room + '/chart_for_class_room_toppers_testwise.json?chart_type=bar',
      container = container,
      xlabel    = 'Student/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel);
};

Charts.drawClassRoomLowestScorersTestwiseChart = function(class_room, container){
  var url       = '/draw_chart/' + class_room + '/chart_for_class_room_lowest_scorers_testwise.json?chart_type=bar',
      container = container,
      xlabel    = 'Student/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel);
};

Charts.drawClassTestToppersChart = function(class_test, container){
  var url       = '/draw_chart/' + class_test + '/class_test_toppers.json?chart_type=bar',
      container = container,
      xlabel    = 'Class Room/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel).resize(600, 350);
};

Charts.drawClassTestLowestScorersChart = function(class_test, container){
  var url       = '/draw_chart/' + class_test + '/class_test_lowest_scorers.json?chart_type=bar',
      container = container,
      xlabel    = 'Class Room/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel).resize(600, 350);
};

Charts.drawClassTestSubjectwiseToppersChart = function(class_test, container){
  var url       = '/draw_chart/' + class_test + '/class_test_subjectwise_toppers.json?chart_type=bar',
      container = container,
      xlabel    = 'Subject/Class Room/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel).resize(600, 350);
};

Charts.drawClassTestSubjectwiseLowestScorersChart = function(class_test, container){
  var url       = '/draw_chart/' + class_test + '/class_test_subjectwise_lowest_scorers.json?chart_type=bar',
      container = container,
      xlabel    = 'Subject/Class Room/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel).resize(600, 350);
};





