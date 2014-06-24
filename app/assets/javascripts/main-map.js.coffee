#= require map

$(document).ready ->
  markers = []

  update_markers = (mapHandler) ->
    parameters = {}
    parameters['after'] = $('#map-time-range').val() unless $('input#all-time').is(':checked')

    $.get '/api/markers', parameters, (result) ->
      for marker in markers
        marker.setMap(null)

      markers = mapHandler.addMarkers(JSON.parse(result))
      handler.bounds.extendWith(markers);

  handler = Gmaps.build('Google')
  handler.buildMap {
    provider:
      zoom: 8,
      center: new google.maps.LatLng(48.202778, 37.805278),
      mapTypeId: google.maps.MapTypeId.TERRAIN
    internal:
      id: 'main-map-area' 
  }, ->
    update_markers(handler)

  $('#map-time-range').slider({
    formater: (value) ->
      'за ' + value + ' ' + pluralize(value, 'час', 'часа', 'часов')
  }).on 'slide', (event) ->
    update_markers(handler)

  $('input#all-time').on 'change', ->
    update_markers(handler)
    $('#main-map-controls .slider').animate({ width: 'toggle' })