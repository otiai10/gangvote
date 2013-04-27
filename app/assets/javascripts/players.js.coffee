# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  Array.prototype.sortByNumber = ()->
    this.sort (a, b)->
      return (parseInt(a) > parseInt(b)) ? 1 : -1

  getCap = (anchor, numbers)->
    for num in numbers
      if parseInt(anchor) <= parseInt(num) 
        return num
    return ''

  # events
  $("#search").on 'click', ()->
    val = $("#search-query").val()
    window.location.href = '#' + val

  numbers = new Array

  $('.anchor').each ()->
    numbers.push parseInt($(this).attr('id'))

  $('.page').on 'click', ()->
    offset = $(this).attr('offset')
    cap = getCap offset, numbers.sortByNumber()
    window.location.href = '#' + cap

  enableDelayLoad({duration:400, baseDOM:'body', doFade: false, immediately:true })
