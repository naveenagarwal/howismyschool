var Schedules = function(){
}

Schedules.getCalenderEvents = function(){

  if(typeof(ScheduleEvents) === "undefined"){
    ScheduleEvents = this;
  }


  var url,
      year = $('span[data-head-year]').html(),
      month = ScheduleEvents.options.translateMonths.indexOf($('span[data-head-month]').html()) + 1;

  url = "/schedules/list?year=" + year + "&month=" + month;

  $.ajax({
    url: url,
  }).done(function(response){
    ScheduleEvents.setEvents(response.events);
  }).fail(function(response){
    alert("Error Loading schedules. Please try after sometime!");
  });
};

Schedules.getDayEvents = function(){
  var day = $(this).data('day'),
      month = $(this).data('month'),
      year = $(this).data('year');

  var url = "/schedules/day_events?year=" + year + "&month=" + month + "&day=" + day;

  $.ajax({
    url: url,
    dataType: 'script'
  });

};

Schedule.noDayEventClick = function(){
  if($("#no_day_events_links").length > 0){

    $("#no_day_events_links").click(function(){
      $("#list_day_schedules").modal("hide");
      $("#new_schedule_link").trigger("click");
    });

  }
};