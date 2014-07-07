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

end
