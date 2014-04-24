// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  $('#information').hide();

  $('a#open').click(function(){
    $('#information').show();
    $('#open').hide();
  });

  $('a#close').click(function(){
    $('#information').hide();
    $('#open').show();
  });
});