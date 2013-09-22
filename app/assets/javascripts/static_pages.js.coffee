# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  newsFeedInterval = setInterval ->
    $el = $('.newsfeed span')
    curLeft = parseInt($el.css('left').replace("px",""), 10)
    $el.css('left', "#{curLeft - 1}px")
  , 25

  contentHeight = null
  $(".bw.block").hover ->
    $this = $(@)
    position = $this.position()
    $popup = $('.popup')
    data = $this.data()
    $popup.html """
    <div class='content'>
      <p class="name">#{data.name}</p>
      <p class="name">#{data.location}</p>
    </div>
    """
    $popup.show()
    contentHeight = parseInt($popup.find('.content').css('height').replace('px',''))
    movement = if $this.hasClass('last-row') then -contentHeight else 150
    $popup.css
      top: position.top + movement
      left: position.left
    console.log 'show'
  , ->
    $('.popup').hide().find('.content').remove()
    console.log 'hide'

  $('.titlebar input').keypress (e) ->
    if e.keyCode == 13
      location = $(e.target).val()
      document.location = "/?location=#{location}"