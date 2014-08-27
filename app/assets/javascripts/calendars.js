// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
		lang: 'es',
	    events: '/events.json',
		  dayClick: function(date, jsEvent, view) {
			 $.ajax({
			           url: "",
			           data: {date: date}
			        })
		    }
    })

});