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

    done: (e, data) ->
      reloadFunctions()

  reloadFunctions = () ->
    $('#images .close').click ->
      removeImage($(this))
    $('.remove-album').click ->
      removeAlbum($(this))

  removeImage = (closeButton) ->
    item = closeButton.parent()
    $.post "remove_image", { "id": closeButton.attr("id") }, () ->
      closeButton.remove()
      item.children(".thumbnail")
        .css("padding-left", "0px")
        .css("padding-right", "0px")
        .animate(width: "0px")
      item.animate width: "0px", ->
        item.remove()

  removeAlbum = (closeButton) ->
    item = closeButton.parent()
    $.post "albums/remove_album", { "id": closeButton.attr("id") }, () ->
      closeButton.remove()
      item.find(".edit-album").remove()
      item.children(".thumbnail")
        .css("padding-top", "0px")
        .css("padding-bottom", "0px")
        .animate height: "0px"
      item.animate height: "0px", () ->
        item.remove()

  $(document).click (e) ->
    if $('#editAlbums, #editImages').has(e.target).length == 0
      $('.close').fadeOut()

  $("#editAlbums, #editImages").click ->
    $('.close').fadeToggle()

  $('.edit-album').click ->
    $("#newAlbumModal form").attr('action', '/albums/' + $(this).attr("id") + '/update_album')
    $("#newAlbumModal #album_name").val($(this).parent().find('.media-body h4 a').text())
    $("#newAlbumModal #album_desc").val($.trim($(this).parent().find('.media-body div').text()))
    $("#newAlbumModalLabel").text("Edit Album")
    $("#newAlbumModal").modal("show")

  $('#newAlbumModal form').submit ->
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
        reloadFunctions()
    return false

  reloadFunctions()
