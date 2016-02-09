// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){

  $(function () {
    $('[data-toggle="tooltip"]').tooltip();
  });

  var collapseCollaborators = function(){ $(".collaborator-delete").hide(); };
  collapseCollaborators();

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
    this.$collaboratorForm = $("#add-collaborator-form");
    this.$finalizedGatheringItems = $("#votable-dashboard, #forms-panel-body");
  };

  Gathering.prototype.init = function() {
    this.addTitleListener();
    this.addModalButtonListener();
    this.addModalCloseListener();
    this.finalizeAjaxCallback();
    this.addCreateFormButtonListener();
    this.addAutoCompleteListener();
    this.addCollaboratorFormReset();
    this.addExpandCollaboratorListener();
    this.addActionButtonListeners();
    this.addCancelButtonListener();
    this.addUnfinalizeListener();
  };

  Gathering.prototype.addExpandCollaboratorListener = function() {
    $(".collaborator").on('click', function(e) {
      $(this).next().toggle();
     }
   );
  };

  Gathering.prototype.addAutoCompleteListener = function() {
    var that = this;
    $(".autocomplete").autocomplete({
      source: "/gatherings/" + this.gatheringId + "/list_autocomplete.json"
      ,
      minLength: 2,
      select: function(event, ui) {
        event.preventDefault();
        var selected_name = ui.item.label;
        var selected_id = ui.item.value;
        $('#add-collaborator-form input[type="hidden"]').val(selected_id);
        $(".ac-input").val(selected_name);
      }
    });
  };

  Gathering.prototype.addActionButtonListeners = function() {
    $('.action-buttons a').click(function(e) {
      e.preventDefault();
      var paneId = $(this).data('pane');
      $(this).parent().addClass('hide-pane');
      $("#" + paneId).addClass('display-pane');
    });
  };

  Gathering.prototype.addCollaboratorFormReset = function (arguments) {
    this.$collaboratorForm.bind('ajax:success', function(e, data, status, xhr){
      this.$collaboratorForm[0].reset();
    }.bind(this) );
  };

  Gathering.prototype.addCreateFormButtonListener = function() {
    $('#create-forms form').bind('ajax:success', function(e, data, status, xhr){
        $(this).parent().removeClass('display-pane');
        $('.action-buttons').removeClass('hide-pane');
    } );
  };

  Gathering.prototype.addCancelButtonListener = function() {
    $('.cancel-button').click(function(e) {
      e.preventDefault();
      $(this).parent().removeClass('display-pane');
      $('.action-buttons').removeClass('hide-pane');
    } );
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

  Gathering.prototype.addUnfinalizeListener = function () {
    var unfinalizeURL = this.gatheringId + '/unfinalize';
    $('#unstaging-button').on('click', function(){
      $.ajax({
          url:  unfinalizeURL,
          type: 'PUT',
          dataType: 'script',
          success: function(modal_data){
            $('.finalize-plan-row').fadeOut();
            $('#votable-dashboard, #forms-panel-body').removeClass('gathering-finalized');
            $('#unstaging-button').replaceWith("<button type='button' id='staging-button' class='btn btn-primary btn-md'>Let's Do It</button>");
            $('#suggested-or-finalized').html("#suggestions");
            this.addModalButtonListener();
          }.bind(this),
          error: function(){
              alert("ajax error");
          }
      });
    }.bind(this) );
  };

  Gathering.prototype.finalizeAjaxCallback = function () {
    var that = this;
    $('#modal-form').bind('ajax:success', function(e, data, status, xhr){
      this.$stagingModal.modal('hide');
      var finalTmpl = $.templates("#finalized-template");
      var finalHtml = finalTmpl.render(data);
      // $(finalHtml).insertAfter(this.$collaboratorsSection);
      //ideally replace a div
      $('#suggested-or-finalized').html(finalHtml);

      this.$finalizedGatheringItems.toggleClass('gathering-finalized');
      $('#staging-button').replaceWith("<button type='button' id='unstaging-button' class='btn btn-danger btn-md'>Change of Plans</button>");
      that.addUnfinalizeListener();
    }.bind(this) );
  };

  var gathering = new Gathering();
  gathering.init();
});
