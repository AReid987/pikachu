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
//= require jquery.ui.all
//= require jquery_ujs
//= require bootstrap
//= require_tree .
$(function() {
  $(document).on("click", "#users th a, #users .pagination a", function() {
    $.getScript(this.href);
    return false;
  });
  $('#users tbody').sortable({axis: 'y',update: function(){
      $.ajax({
        url: '/users/sort',
        type: 'post',
        data: $('#users tbody').sortable('serialize'),
        dataType: 'script',
        complete: function(request){
          $('#users tbody').effect('highlight');
        }
      });
    }
  });
	$("#users_search input").keyup(function() {
    $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, "script");
    return false;
  });
  $(document).on('ajax:success', '#delete_user', function(e) {
    $(e.currentTarget).closest('tr').fadeOut();
  });
  $(document).on("click", "#admins th a, #admins .pagination a", function() {
    $.getScript(this.href);
    return false;
  });
  $('#admins tbody').sortable({axis: 'y',update: function(){
      $.ajax({
        url: '/admins/sort',
        type: 'post',
        data: $('#admins tbody').sortable('serialize'),
        dataType: 'script',
        complete: function(request){
          $('#admins tbody').effect('highlight');
        }
      });
    }
  });
  $("#admins_search input").keyup(function() {
    $.get($("#admins_search").attr("action"), $("#admins_search").serialize(), null, "script");
    return false;
  });
});