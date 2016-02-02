// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
  $('.gathering-title').dblclick(function(){
    var oldTitle = $('.gathering-title').text();
    var $container = $('.title-container');
    debugger;
    $container.empty().append("<input placeholder=" + (oldTitle) + "'></input>");
    // debugger;
  });
});


//get current title
//replace with textfield
//
