# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.tab li').click ->
    index = undefined
    index = $('.tab li').index(this)
    $('.content li').css 'display', 'none'
    $('.content li').eq(index).css 'display', 'block'
    $('.tab li').removeClass 'select'
    $(this).addClass 'select'
