# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
$ ->
  $('#hiddenForm').submit (e)->
    e.preventDefault()

  $('#hiddenField').focus().keyup (e)->
    e.preventDefault()
    if(e.keyCode >= 48)
      $('#hoge').append(String.fromCharCode(e.keyCode))
    console.log e
  $(document).click (e)->
    $('#hiddenField').focus()
