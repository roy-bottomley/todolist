@toDoDemoApp.factory 'Weather', [  'serverInterface', (serverInterface) ->
  class Weather extends serverInterface
    constructor: () ->
      # server address for weather
      @locations = []
      @serverInterface = new serverInterface('/api/weathers/', @locations)
      @show()

      
    show: () ->
      @currentLocation = 'home' if !@currentLocation?
      @serverInterface.show(@currentLocation).then (weather) =>

        weather_details = {
          url: weather.doc.image.url,
          temperature: weather.doc.item.condition.temp,
          units: weather.doc.units.temperature,
          title: weather.title,
          conditions: weather.doc.item.condition.description,
          forecasts: [],
          link: weather.doc.link,
        }

        for day in [0..1]
          forecast = {
            day: weather.doc.item.forecast[day].day
            text: weather.doc.item.forecast[day].text
            high: weather.doc.item.forecast[day].high
            low: weather.doc.item.forecast[day].low
          }
          weather_details.forecasts.push(forecast)

        @currentLocation = weather.doc.location.city
        @locations = [weather_details]

]