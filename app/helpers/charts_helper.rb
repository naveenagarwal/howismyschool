module ChartsHelper
  def barchart_for_latest_test_results(container)
    "
      <script type='text/javascript'>
        Charts.drawLatestTestResultsChart('#{container}');
      </script>
    ".html_safe
  end

  def barchart_for_class_room(class_room_id, container)
    "
      <script type='text/javascript'>
        Charts.drawClassRoomChart('#{class_room_id}','#{container}');
      </script>
    ".html_safe
  end

  def barchart_for_class_room_toppers_subjectwise(class_room_id, container)
    "
      <script type='text/javascript'>
        Charts.drawClassRoomToppersSubjectwiseChart('#{class_room_id}','#{container}');
      </script>
    ".html_safe
  end

  def barchart_for_class_room_toppers_testwise(class_room_id, container)
    "
      <script type='text/javascript'>
        Charts.drawClassRoomToppersTestwiseChart('#{class_room_id}','#{container}');
      </script>
    ".html_safe
  end

  def barchart_for_class_room_lowest_scoreres_testwise(class_room_id, container)
    "
      <script type='text/javascript'>
        Charts.drawClassRoomLowestScorersTestwiseChart('#{class_room_id}','#{container}');
      </script>
    ".html_safe
  end

  def barchart_for_class_test_toppers(class_test_id, container)
    "
      <script type='text/javascript'>
        Charts.drawClassTestToppersChart('#{class_test_id}','#{container}');
      </script>
    ".html_safe
  end

  def barchart_for_class_test_lowest_scorers(class_test_id, container)
    "
      <script type='text/javascript'>
        Charts.drawClassTestLowestScorersChart('#{class_test_id}','#{container}');
      </script>
    ".html_safe
  end

  def barchart_for_class_test_toppers_subjectwise(class_test_id, container)
    "
      <script type='text/javascript'>
        Charts.drawClassTestSubjectwiseToppersChart('#{class_test_id}','#{container}');
      </script>
    ".html_safe
  end

  def barchart_for_class_test_lowest_scorers_subjectwise(class_test_id, container)
    "
      <script type='text/javascript'>
        Charts.drawClassTestSubjectwiseLowestScorersChart('#{class_test_id}','#{container}');
      </script>
    ".html_safe
  end

  def barchart_for_subject_toppers(subject_id, container)
    "
      <script type='text/javascript'>
        Charts.drawSubjectToppersChart('#{subject_id}','#{container}');
      </script>
    ".html_safe
  end

  def barchart_for_suibject_lowest_scorers(subject_id, container)
    "
      <script type='text/javascript'>
        Charts.drawSubjectLowestScorersChart('#{subject_id}','#{container}');
      </script>
    ".html_safe
  end

end
