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

  $('.remove-album').click ->
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

  $('.edit-album').click ->
    id = $(this).attr("id")
    $("#newAlbumModal form").attr('action', '/albums/' + id + '/update_album')
    $("#newAlbumModal #album_name").val($(this).parent().find('.media-body h4 a').text())
    $("#newAlbumModal #album_desc").val($.trim($(this).parent().find('.media-body div').text()))
    $("#newAlbumModalLabel").text("Edit Album")
    $("#newAlbumModal").modal("show")

  $('#newAlbumModal form').submit () ->
    valuesToSubmit = $(this).serialize()
    $.ajax
      url: $(this).attr('action')
      data: valuesToSubmit
      method: "POST"
      dataType: "JSON"
      success: (json) ->
        if typeof json.partial != 'undefined'
          $("#albumsList").append(json.partial)
        else
          album = $("#album_" + json.id)
          album.find(".media-body h4 a").text(json.name)
          album.find(".media-body div").text(json.desc)
          $('.media .close').fadeToggle("slow")

        $("#newAlbumModal form").attr('action', '/albums')
        $("#newAlbumModal #album_name").val("")
        $("#newAlbumModal #album_desc").val("")
        $("#newAlbumModalLabel").text("New Album")
        $("#newAlbumModal").modal("hide")
    return false
