// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
  $('.gathering-title').dblclick(function(){
    var oldTitle = $('.gathering-title').text();
    var $container = $('.title-container');

    var textbox = document.createElement('input');
    textbox.type = 'text';
    textbox.id = 'title';

    $('.gathering-title').html(textbox);
    $('.gathering-title').off();
    $('#title').on('keypress', function(e){
      if(e.keyCode === 13){
        $('.gathering-title').html($('#title').val());
      }
    });
    debugger;
    // $container.empty().append("<input placeholder=" + (oldTitle) + "'></input>");
    // debugger;
  });
});


//get current title
//replace with textfield
//
