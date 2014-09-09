// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
		titleFormat: {
		  month: "MMMM yyyy",
		  week: "d.[ MMMM][ yyyy]{ - d. MMMM yyyy}",
		  day: "dddd, d.MMMM yyyy"},
		columnFormat: {
		  month: "ddd",
		  week: "ddd d.M.",
		  day: "dddd d.M."},
		timeFormat: {"":"h(:mm)t"},
		isRTL: false,
		firstDay: 1,
		monthNames: ["Janeiro","Feveiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"],
		monthNamesShort: ["Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Sep","Out","Nov","Dez"],
		dayNames: ["Sonntag","Montag","Dienstag","Mittwoch","Donnerstag","Freitag","Samstag"],
		dayNamesShort: ["Dom","Seg","Ter","Qua","Qui","Sex","Sáb"],
		buttonText: {
		  prev: "&nbsp;&#9668;&nbsp;",
		  next: "&nbsp;&#9658;&nbsp;",
		  prevYear: "&nbsp;&lt;&lt;&nbsp;",
		  nextYear: "&nbsp;&gt;&gt;&nbsp;",
		  today: "Hoje",
		  month: "Mês",
		  week: "Semana",
		  day: "Dia"},


		allDayText: "ganztägig",

	    events: '/events.json',
		eventColor: '#4169E1',
	
	    dayClick: function(date, jsEvent, view) {
			response = $.ajax({
			  url: "/calendar_days/1.html",
			});
			response.done(function(){window.location = "/calendar_days/find/?date=" + date  });
	    }
    })

});