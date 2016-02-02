// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
  $('.gathering-title').dblclick(function(){
    var oldTitle = $('.gathering-title').text();
    var gatheringId = $('.title-container').data('id');
    var textbox = document.createElement('input');
    textbox.type = 'text';
    textbox.id = 'title';
    textbox.value = oldTitle;

    $('.gathering-title').html(textbox);
    // $('.gathering-title').off();
    $('#title').on('keypress', function(e){
      if(e.keyCode === 13){
        var title = $('#title').val();
        $('.gathering-title').html($('#title').val());

        var URL =  gatheringId;
        $.ajax({
          method: 'patch',
          url: URL,
          dataType: 'script',
          data: {
            gathering: {
              id: gatheringId,
              title: title
            }
          }
        });
      }
    });


    // $(document).on();
  });
});


//get current title
//replace with textfield
//how to get new title to controller...
//
