#= require jquery.ui.datepicker
#= require jquery.ui.datepicker-ru

$(document).ready ->
  datepicker = $('#datepicker')
  toggle_datepicker = $('#toggle-datepicker')
  turnoff_datepicker = $('#turnoff-datepicker')

  toggle_datepicker.click ->
    datepicker.slideToggle()

  turnoff_datepicker.click ->
    params = getParams
    params_array = []

    # delete date parameter
    delete params['date']

    # convert hash to array
    for key, value of params
      params_array.push [key, value].join('=')

    # reload page with new parameters
    window.location.search = params_array.join('&')

  datepicker.datepicker(
    dateFormat: 'dd-mm-yy'
    onSelect: (date) ->
      params = getParams
      params_array = []

      # add/replace date parameter
      params['date'] = date

      # convert hash to array
      for key, value of params
        params_array.push [key, value].join('=')

      # reload page with new parameters
      window.location.search = params_array.join('&')
  )

  getParams = ->
    params = {}

    # get current url parameters
    query = window.location.search.substring(1)
    if query.length
      raw_vars = query.split("&")

      for v in raw_vars
        [key, val] = v.split("=")
        params[key] = decodeURIComponent(val)

    params