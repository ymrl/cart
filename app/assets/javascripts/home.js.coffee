# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
$ ->
  buffer = ""
  $('#hiddenForm').submit (e)->
    e.preventDefault()

  $('#hiddenField').focus().keyup (e)->
    e.preventDefault()
    if e.keyCode >= 48 and e.keyCode <= 57
      buffer += String.fromCharCode(e.keyCode)
    else if e.keyCode == 13
      $('#hoge').append(buffer)
      buffer = ""
    console.log e.keyCode
  invisibleLayer = $('<div>').appendTo('body')
  invisibleLayer.css
    width:  $(window).outerWidth()
    height: $(window).outerHeight()
    position: 'absolute'
    top:0
    left:0
    zIndex:-1
  invisibleLayer.click (e)->
    $('#hiddenField').focus()
