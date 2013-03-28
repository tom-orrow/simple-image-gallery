# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#fileupload').fileupload
    dataType: "script"

    progressall: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $('#progressbar').removeClass("hide")
      $('#progress .bar').css('width', progress + '%')
      if progress == 100
        $('#progressbar').addClass("hide")

  $("#editImages").click ->
    $('#images .close').fadeToggle("slow")

  $('#images .close').click ->
    id = $(this).attr("id")
    button = $(this)
    item = $(this).parent()
    $.post "remove_image", { "id": id }, () ->
      button.remove()
      item.children(".thumbnail").css("padding-left", "0px")
      item.children(".thumbnail").css("padding-right", "0px")
      item.animate width: "0px", () ->
        item.remove()
      item.children(".thumbnail").animate width: "0px"

  $("#editAlbums").click ->
    $('.media .close').fadeToggle("slow")

  $('.media .close').click ->
    id = $(this).attr("id")
    button = $(this)
    item = $(this).parent()
    $.post "albums/remove_album", { "id": id }, () ->
      button.remove()
      item.children(".thumbnail").css("padding-top", "0px")
      item.children(".thumbnail").css("padding-bottom", "0px")
      item.animate height: "0px", () ->
        item.remove()
      item.children(".thumbnail").animate height: "0px"