#= require jquery.ui.datepicker
#= require jquery.ui.datepicker-ru

$(document).ready ->
  markers = []

  update_markers = (mapHandler, date = null) ->
    parameters = {}

    unless $('input#all-time').is(':checked')
      if date
        parameters['date'] = date
      else if $('input#datepicker-time').is(':checked')
        parameters['date'] = $('#datepicker').val()
      else
        parameters['after'] = $('#map-time-range').val()

    $.get '/api/markers', parameters, (result) ->
      for marker in markers
        marker.setMap(null)

      return unless result.length

      markers = mapHandler.addMarkers(JSON.parse(result))
      handler.bounds.extendWith(markers);

  handler = Gmaps.build('Google')
  handler.buildMap {
    provider:
      zoom: 6,
      center: new google.maps.LatLng(48.202778, 31.805278),
      mapTypeId: google.maps.MapTypeId.TERRAIN
    internal:
      id: 'main-map-area' 
  }, ->
    update_markers(handler)

  $('#datepicker').datepicker(
    maxDate: 0
    dateFormat: 'dd-mm-yy'
    onSelect: (date) ->
      update_markers(handler, date)
  )

  $('#map-time-range').slider(
    formater: (value) ->
      'за ' + value + ' ' + pluralize(value, 'час', 'часа', 'часов')
  ).on 'slide', (event) ->
    update_markers(handler)

  $('input#all-time').on 'change', ->
    update_markers(handler)

  $('input#datepicker-time').on 'change', ->
    update_markers(handler)
    $('#main-map-controls .slider').animate({ width: 'toggle' })
    $('#main-map-controls-datepicker').slideToggle()