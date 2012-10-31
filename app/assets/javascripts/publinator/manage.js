// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require_directory "./manage"
//= require_self

function moveObject(selector, from, to) {
  $(selector).appendTo($(to));
  $(selector).find($(from)).remove();
}

function loadPreview() {
  preview_text = $($('textarea')[0]).val();
  $.ajax({
    url: "preview",
    data: {preview_text: preview_text}
  }).done(function( msg ) {
    $('#preview').html( msg );
  });
}

$(function() {
  $(".sortable_list").sortable({
    update: function(){
      $.ajax({
        type: 'post',
        data: $('.sortable_list').sortable('serialize'),
        dataType: 'script',
        complete: function(request){ $('.sortable_list').effect('highlight');},
        url: $(".sortable_list").attr("sorturl")
      })
    }
  });

  $(".sortable_list").disableSelection();

  $("#tabs").tabs();

  $("fieldset.actions button").button({ icons: { primary: "ui-icon-check" }});
  $("#publishable_type_button").button();
  $(".new_button").button({ icons: { primary: "ui-icon-document" }});




  $(document).on("keypress keydown", function(event) {
    console.log(event);
    if (event.ctrlKey || event.metaKey) {
      if (event.keyCode == 83) {
        event.preventDefault();
        event.stopPropagation();
        $('form').submit();
        return false;
      }
      else if (event.keyCode == 16) {
        event.preventDefault();
        event.stopPropagation();
        loadPreview();
        return false;

      }
    }
  });

  $(".toggle_details").on("click", function(event) {
    event.preventDefault();
    $(event.currentTarget).siblings('.object_details').toggle();
  });
});

