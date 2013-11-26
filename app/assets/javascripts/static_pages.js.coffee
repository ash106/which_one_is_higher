$ ->
  mapOptions =
    center: new google.maps.LatLng(-34.397, 150.644)
    zoom: 8
    mapTypeId: google.maps.MapTypeId.TERRAIN
  map = new google.maps.Map($("#map_canvas")[0], mapOptions)
  geocoder = new google.maps.Geocoder()
  elevator = new google.maps.ElevationService()
  slc_pos = new google.maps.LatLng(40.743668, -111.885232)
  vicksburg_pos = new google.maps.LatLng(32.394939, -90.782712)
  slc = new google.maps.Marker(
    position: slc_pos
    map: map
  )
  vicksburg = new google.maps.Marker(
    position: vicksburg_pos,
    map: map
  )
  locations = [slc, vicksburg]
  info_window_one = new google.maps.InfoWindow(maxWidth: 100)
  info_window_two = new google.maps.InfoWindow(maxWidth: 100)
  info_windows = [info_window_one, info_window_two]
  elevation_results = [0,1]
  isFinished = []

  setBounds = ->
    map_bounds = new google.maps.LatLngBounds(null)
    for location in locations
      map_bounds.extend location.getPosition()
    map.fitBounds map_bounds
    map.panToBounds map_bounds
    map.setZoom map.getZoom() - 1

  codeAddress = (address, order) ->
    geocoder.geocode
      address: address
    , (results, status) ->
      if status is google.maps.GeocoderStatus.OK
        locations[order].setPosition results[0].geometry.location
        getElevation order
      else
        alert "Geocode was not successful for the following reason: " + status

  getElevation = (order) ->
    elevation_locs = [locations[order].getPosition()]
    positionalRequest = 
      'locations': elevation_locs
    elevator.getElevationForLocations positionalRequest, (results, status) ->
      if status is google.maps.ElevationStatus.OK
        if results[0]
          elevation_results[order] = Math.round(results[0].elevation * 3.280839895)
          info_windows[order].setContent elevation_results[order] + " ft"
          info_windows[order].open map, locations[order]
          isFinished.push("yes")
          console.debug(isFinished)
          console.debug(elevation_results)
          if(isFinished.length == 2)
            console.debug("HERRO???")
            compareElevations()
        else
          alert "No results found"
      else
        alert "Elevation service failed due to: " + status

  compareElevations = ->
    if elevation_results[0] > elevation_results[1]
      info_windows[0].setContent "<h6>WINNER</h6>\n" + info_windows[0].getContent()
      $('#winner').html '<p>' + $("#compare_location_one").val() + ' is the winner!</p>'
      $('#winner').show()
    else
      info_windows[1].setContent "<h6>WINNER</h6>\n" + info_windows[1].getContent()
      $('#winner').html '<p>' + $("#compare_location_two").val() + ' is the winner!</p>'
      $('#winner').show()
    setBounds()


  $(".compare").submit (event) ->
    # alert $('#compare_location_one').val() + " vs. " + $('#compare_location_two').val()
    isFinished = []
    $('#winner').hide()
    codeAddress $("#compare_location_one").val(), 0
    codeAddress $("#compare_location_two").val(), 1
    return false

