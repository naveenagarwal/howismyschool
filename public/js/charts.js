var colors = ['#AF0202', '#EC7A00', '#FCD200', '#81C714'];

function Charts(){
}

Charts.drawLatestTestResultsChart = function(container){
  var myChart = new JSChart(container, 'bar');
  myChart.setDataJSON('/draw_chart/chart_for_latest_test_results.json?chart_type=bar');
  myChart.setAxisNameX('Tests');
  myChart.setAxisNameY('Percentage(%)', true);
  myChart.colorizeBars(colors);
  myChart.setFontFamily('"Comic Sans MS", cursive, sans-serif');
  myChart.setLabelFontFamily('"Comic Sans MS", cursive, sans-serif');
  myChart.draw();
}

Charts.drawClassRoomChart = function(class_room, container){
  var myChart = new JSChart(container, 'bar');
  myChart.setDataJSON('/draw_chart/' + class_room + '/chart_for_class_room.json?chart_type=bar');
  myChart.setAxisNameX('Tests');
  myChart.setAxisNameY('Percentage(%)', true);
  myChart.colorizeBars(colors);
  myChart.setFontFamily('"Comic Sans MS", cursive, sans-serif');
  myChart.setLabelFontFamily('"Comic Sans MS", cursive, sans-serif');
  myChart.draw();
}

Charts.drawClassRoomToppersSubjectwiseChart = function(class_room, container){
  var myChart = new JSChart(container, 'bar');
  myChart.setDataJSON('/draw_chart/' + class_room + '/chart_for_class_room_toppers_subjectwise.json?chart_type=bar');
  myChart.setAxisNameX('Student/Subejct/Test');
  myChart.setAxisNameY('Percentage(%)', true);
  myChart.colorizeBars(colors);
  myChart.setFontFamily('"Comic Sans MS", cursive, sans-serif');
  myChart.setLabelFontFamily('"Comic Sans MS", cursive, sans-serif');
  myChart.draw();
}

Charts.drawClassRoomToppersTestwiseChart = function(class_room, container){
  var myChart = new JSChart(container, 'bar');
  myChart.setDataJSON('/draw_chart/' + class_room + '/chart_for_class_room_toppers_testwise.json?chart_type=bar');
  myChart.setAxisNameX('Student/Test');
  myChart.setAxisNameY('Percentage(%)', true);
  myChart.colorizeBars(colors);
  myChart.setFontFamily('"Comic Sans MS", cursive, sans-serif');
  myChart.setLabelFontFamily('"Comic Sans MS", cursive, sans-serif');
  myChart.draw();
}