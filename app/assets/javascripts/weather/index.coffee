weatherIndex =
  index: ->
    $table = $('table#weather-index tbody')
    $.ajax
      url: '/api/frontend/weather'
      dataType: 'json'
      method: 'GET'
      processData: false
      contentType: false
      success: (data) ->
        html = []
        for loc in data
          html.push "<tr id='loc-#{loc.id}'><td>#{loc.name} (#{loc.zip})</td>" +
                                           "<td>#{loc.current_temperature}</td>" +
                                           "<td>#{loc.low_temperature}</td>" +
                                           "<td>#{loc.high_temperature}</td>" +
                                           "<td>#{loc.average_temperature}</td></tr>"
        $table.html(html)
      error: (data) ->
        console.log(data)

  refresh: ->
    $.ajax
      url: '/api/frontend/weather/refresh'
      dataType: 'json'
      method: 'POST'
      processData: false
      contentType: false
      success: (data) ->
        weatherIndex.index()
      error: (data) ->
        console.log(data)

$(document).on 'turbolinks:load', ->
  weatherIndex.index()
  $('#refresh').on 'click', (e) ->
    weatherIndex.refresh()
