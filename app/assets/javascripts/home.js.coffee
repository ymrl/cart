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
