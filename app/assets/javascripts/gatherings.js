// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
  var titleKeypressListener = function(e) {
    if(e.keyCode === 13) {
      var title = $('#title').val();
      var URL =  this.gatheringId;
      $.ajax({
        method: 'patch',
        url: URL,
        dataType: 'script',
        data: {
          gathering: {
            id: this.gatheringId,
            title: title
          }},
        success: function(){
          this.$gatheringTitle.html($('#title').val());
        }.bind(this)
      });
    }
  };

  var Gathering = function() {
    this.$gatheringTitle = $('.gathering-title');
    this.$gatheringTitleContainer = $('#gathering-title-container');
    this.$stagingButton = $('#staging-button');
    this.$stagingModalTitle = $('#staging-modal-label');
    this.$stagingModalBody = $('#staging-modal .modal-body');
    this.$stagingModal = $('#staging-modal');
    this.gatheringId = this.$gatheringTitleContainer.data('id');
  };

  Gathering.prototype.init = function() {
    this.addTitleListener();
    this.addModalButtonListener();
  };

  Gathering.prototype.addTitleListener = function() {
    this.$gatheringTitle.dblclick(function() {
      var oldTitle = this.$gatheringTitle.text();
      var textbox = document.createElement('input');
      textbox.type = 'text';
      textbox.id = 'title';
      textbox.value = oldTitle;
      this.$gatheringTitle.html(textbox);
      $('#title').on('keypress', titleKeypressListener.bind(this) );
    }.bind(this) );
  };

  Gathering.prototype.addModalButtonListener = function() {
    $('#staging-button').on('click', function(e) {
      e.preventDefault();
      var stagingUrl = this.gatheringId + '/stage';
      $.ajax({
          url:  stagingUrl,
          type: 'GET',
          dataType: 'json',
          success: function(modal_data){
            // debugger;
              var checked = "";
              modal_data.moments.forEach(function(moment){
                if(moment.suggested){
                  checked = " checked";
                }else{
                  checked = "";
                }
                $("#moments-buttons").prepend('<input type="radio" name="moment" value=' + moment.id + checked + '>  ' + moment.time +'<br>');
              });
              modal_data.activities.forEach(function(activity){
                if(activity.suggested){
                  checked = " checked";
                }else{
                  checked = "";
                }
                $("#activities-buttons").prepend('<input type="radio" name="activity" value=' + activity.id + checked + '>  ' + activity.description +'<br>');
              });
              modal_data.places.forEach(function(place){
                if(place.suggested){
                  checked = " checked";
                }else{
                  checked = "";
                }
                $("#places-buttons").prepend('<input type="radio" name="place" value=' + place.id + checked + '>  ' + place.name +'<br>');
              });
              this.$stagingModalTitle.text("Finalizing " + modal_data.gathering_title);
              // this.$stagingModalBody.html(JSON.stringify(modal_data));
              this.$stagingModal.modal('show');
          }.bind(this),
          error: function(){
              alert("ajax error");
          }
      });
    }.bind(this) );
  };

  var gathering = new Gathering();
  gathering.init();
});
