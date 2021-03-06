var Student = function(){
}

Student.initializeStudentScoreCharts = function(){

  if($("#student_test_score").length > 0){
    $("#student_test_score").click(function(){
      var student = $(this).data("student"),
          container = $(this).data("container"),
          url = '/draw_chart/' + student + '/tests_score.json?chart_type=bar';

      Charts.drawStudentScore(url, student, container);
    });
  }

  if($("#student_subjects_score").length > 0){
      $("#student_subjects_score").click(function(){
        var student = $(this).data("student"),
            container = $(this).data("container"),
            url = '/draw_chart/' + student + '/subjects_score.json?chart_type=bar';

        Charts.drawStudentScore(url, student, container);
      });
  }

  if($("#student_subjects_yearwise_score").length > 0){
      $("#student_subjects_yearwise_score").click(function(){
        var student = $(this).data("student"),
            container = $(this).data("container"),
            xlabel = 'Subject/Test/Class Room/Year',
            url = '/draw_chart/' + student + '/subjects_yearwise_score.json?chart_type=bar';

        Charts.drawStudentScore(url, student, container, xlabel);
      });
  }

  $(document).on("click", "#student_generic_modalbox_link", function(){
    $("#student_more_modalboxdal").hide();
    $("#student_generic_modalboxdal").show();
  });

  $(document).on("click", "#student_more_modalbox_link", function(){
    $("#student_more_modalboxdal").show();
    $("#student_generic_modalboxdal").hide();
  });
};
