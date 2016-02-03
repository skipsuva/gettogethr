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
    $('#title').on('keypress', function(e){
      if(e.keyCode === 13){

        var title = $('#title').val();

        var URL =  gatheringId;
        $.ajax({
          method: 'patch',
          url: URL,
          dataType: 'script',
          data: {
            gathering: {
              id: gatheringId,
              title: title
            }},
          success: function(){
            $('.gathering-title').html($('#title').val());
          }
        });
      }
    });
  });

  $('#staging-button').on('click', function(e) {
    e.preventDefault();
    var id = $('#gathering-title-container').data('id');
    var stagingUrl = id + '/stage';
    $.ajax({
        url:  stagingUrl,
        type: 'GET',
        dataType: 'json',
        success: function(modal_data){
            // $('#staging-modal .modal-body').html(modal_data);
            $('#staging-modal .modal-body').html(JSON.stringify(modal_data));
            $('#staging-modal').modal('show');
        },
        error: function(){
            alert("ajax error");
        }  
    });  
  });
});
