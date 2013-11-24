gm_init = ->
  gm_center = new google.maps.LatLng(40.743668, -111.885232)
  gm_map_type = google.maps.MapTypeId.TERRAIN
  map_options = {center: gm_center, zoom: 12, mapTypeId: gm_map_type}
  new google.maps.Map(@map_canvas,map_options);

geo_init = ->
  new google.maps.Geocoder()

code_address_one = (geocoder, locations) ->
  address = $('#address_one').val()
  geocoder.geocode
    address: address
  , (results, status) ->
    if status is google.maps.GeocoderStatus.OK
      locations[0] = results[0].geometry.location
    else
      alert "Geocode was not successful for the following reason: " + status

code_address_two = (geocoder, locations) ->
  address = $('#address_two').val()
  geocoder.geocode
    address: address
  , (results, status) ->
    if status is google.maps.GeocoderStatus.OK
      locations[1] = results[0].geometry.location
    else
      alert "Geocode was not successful for the following reason: " + status

set_all_map = (map, markers) ->
  for marker in markers
    marker.setMap(map)

clear_markers = (markers) ->
  set_all_map(null, markers)
  markers = []

$ ->
  mapOptions =
    center: new google.maps.LatLng(-34.397, 150.644)
    zoom: 8
    mapTypeId: google.maps.MapTypeId.TERRAIN
  map = new google.maps.Map($("#map_canvas")[0], mapOptions)
  $(".compare").submit (event) ->
    alert $('#compare_location_one').val()
    return false

