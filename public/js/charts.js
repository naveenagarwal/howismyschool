var colors = new Array('#AF0202', '#EC7A00', '#FCD200', '#81C714', '#0F0F0F', '#F77777', '#2ea5cd', '#150937', '#E2D2B0');

var getRandomColorArray = function(returnArraylength){
  var val,
      array = [];

  for(var i=0; i < returnArraylength;){
    val = "#" + Math.random().toString(16).slice(2, 8);
    if(array.indexOf(val) == -1){
      array.push(val);
      i++;
    }
    if(array.length >= returnArraylength){
      break;
    }
  }
  return array;
}

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

  var newClorsArray = getRandomColorArray(myChart.ml.bi.length);

  myChart.colorizeBars(newClorsArray);
  myChart.draw();
  myChart.resize(500, 350)
  return myChart;
};

Charts.drawChartFromArray = function(data, container, xlabel, ylabel){
  var myChart = new JSChart(container, 'bar');
  myChart.setDataArray(data);
  myChart.setAxisNameX(xlabel);
  myChart.setAxisNameY(ylabel, true);
  myChart.setAxisNameColor("#000000");
  myChart.setAxisValuesColor("#000000");
  myChart.setBarValuesColor("#000000");
  myChart.setBarValuesDecimals(2);
  myChart.setLabelAlignX(true);

  var newClorsArray = getRandomColorArray(myChart.ml.bi.length);

  myChart.colorizeBars(newClorsArray);
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

Charts.drawSubjectToppersChart = function(subject, container){
  var url       = '/draw_chart/' + subject + '/subject_toppers.json?chart_type=bar',
      container = container,
      xlabel    = 'Student-RollNo/Class Room/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel).resize(600, 350);
};

Charts.drawSubjectLowestScorersChart = function(subject, container){
  var url       = '/draw_chart/' + subject + '/subject_lowest_scorers.json?chart_type=bar',
      container = container,
      xlabel    = 'Student-RollNo/Class Room/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel).resize(600, 350);
};

Charts.drawStudentToppersChart = function(student, container){
  var url       = '/draw_chart/' + student + '/student_toppers.json?chart_type=bar',
      container = container,
      xlabel    = 'Subject/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel).resize(600, 350);
};

Charts.drawStudentLowestScorersChart = function(student, container){
  var url       = '/draw_chart/' + student + '/student_lowest_scorers.json?chart_type=bar',
      container = container,
      xlabel    = 'Subject/Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel).resize(600, 350);
};

Charts.drawStudentOverallChart = function(student, container){
  var url       = '/draw_chart/' + student + '/student_overall_performance.json?chart_type=bar',
      container = container,
      xlabel    = 'Test',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel).resize(600, 350);
};

Charts.drawStudentScore = function(dataURL, student, container, labelX, labelY){
  if(typeof(labelX) === "undefined"){
    var labelX = null;
  }
  if(typeof(labelY) === "undefined"){
    var labelY = null;
  }

  var url       = dataURL,
      container = container,
      xlabel    = labelX || 'Subject/Test/Class Room',
      ylabel    = labelY || 'Percentage(%)';

  $.ajax({
    url: url,
    dataType: 'script',
    type: "GET"
  }).complete(function(response){
    var data = JSON.parse(response.responseText).JSChart.datasets,
        i = 0;

    $("#" + container).html("");

    for(dataset in data){
      $("#" + container).append(Charts.createChartBlock(i));
      Charts.drawChartFromArray(data[dataset].data, "student_chart_container" + i, xlabel, ylabel).resize(1200, 350);
      i++;
    }

  });
}

Charts.createChartBlock = function(sequence){
  var html = '\
    <div class="center-block inline-div2">\
        <div class="have-margin">\
          <div id="student_chart_container' + sequence + '">\
          </div>\
        </div>\
    </div>\
    <br>\
  ';

  return html;
}


// Pie Charts

Charts.drawPieChart = function(url, container){
  var myChart = new JSChart(container, 'pie');
  myChart.setDataJSON(url);
  myChart.setPieRadius(100);
  myChart.setPieUnitsFontSize(8);

  var newClorsArray = [];
  for(var i=0; i<myChart.ml.bi.length; i++){
    newClorsArray.push(colors[i]);
  }

  myChart.colorizePie(newClorsArray);
  myChart.draw();

  return myChart;
};

Charts.drawClassRoomPieChart = function(class_room, class_test, container){
  var url       = '/draw_chart/' + class_room + '/class_room_tests_pass_fail_details/' + class_test + '.json?chart_type=pie',
      container = container;

  Charts.drawPieChart(url, container);
};

Charts.drawClassTestFullTestResultChart = function(class_test, test_id, container){
  var url       = '/draw_chart/class_test_full_test_result/'+ class_test + '/' + test_id + '.json?chart_type=bar',
      container = container,
      xlabel    = 'Stdeunt-Roll Number',
      ylabel    = 'Percentage(%)';

  Charts.drawChart(url, container, xlabel, ylabel).resize(1200, 350);
};