# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $colors = [
    '#000'
    '#333'
    '#666'
    '#999'
  ]
  count = $colors.length
  i = 0
  while(i < $('.students-index-image').length)
    idx = parseInt(Math.random() * count)
    $('.students-index-image').eq(i).css 'background-color', $colors[idx]
    i++;