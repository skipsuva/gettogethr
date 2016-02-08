// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
  
  $(function () {
    $('[data-toggle="tooltip"]').tooltip();
  });

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
    this.$newItemForms = $('.new_moment, .new_activity, .new_place');
    this.$titleRow = $('#title-row');
    this.$votableCards = $('#votable-cards');
    this.$votableForms = $('#votable-forms');
    this.$autocomplete = $(".autocomplete");
    this.$collaboratorsSection = $("#collaborators-panel");
  };

  Gathering.prototype.init = function() {
    this.addTitleListener();
    this.addModalButtonListener();
    this.addModalCloseListener();
    this.finalizeAjaxCallback();
    this.addCreateFormButtonListener();
    // this.addAutocomplete();
  };

  // Gathering.prototype.addAutocomplete = function() {
  //   availableTags = [
  //   "Alice",
  //   "Bob",
  //   "Charlie",
  //   ];
  //   this.$autocomplete.autocomplete({
  //     source: availableTags
  //   });
  // }

  Gathering.prototype.addCreateFormButtonListener = function() {
    $('#create-forms form').bind('ajax:success', function(e, data, status, xhr){
      if(this.$collaboratorsSection.hasClass('hidden')) {
        debugger;
        this.$collaboratorsSection.fadeIn();
        this.$collaboratorsSection.removeClass('hidden');
      }
    }.bind(this) );
  }

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
            var tmpl = $.templates("#modal-template");
            var html = tmpl.render(modal_data);
            $('.modal-body form').prepend(html);
            this.$stagingModalTitle.text("Finalizing " + modal_data.gathering_title);
            this.$stagingModal.modal('show');
          }.bind(this),
          error: function(){
              alert("ajax error");
          }
      });
    }.bind(this) );
  };

  Gathering.prototype.addModalCloseListener = function () {
    this.$stagingModal.on('shown.bs.modal', function () {
      $(this).on('hidden.bs.modal', function () {
        $('.finalize-buttons-row').remove();
      });
    });
  };

  Gathering.prototype.finalizeAjaxCallback = function () {
    $('#modal-form').bind('ajax:success', function(e, data, status, xhr){
      this.$stagingModal.modal('hide');
      var finalTmpl = $.templates("#finalized-template");
      var finalHtml = finalTmpl.render(data);
      $(finalHtml).insertAfter(this.$titleRow);
      this.$votableCards.toggleClass('gathering-finalized');
      this.$votableForms.fadeOut();
    }.bind(this) );
  };

  var gathering = new Gathering();
  gathering.init();
});
