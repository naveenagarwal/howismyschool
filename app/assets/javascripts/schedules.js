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
}