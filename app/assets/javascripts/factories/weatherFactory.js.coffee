@toDoDemoApp.factory 'weatherFactory', [  'serverInterface', (serverInterface) ->
  class weatherFactory extends serverInterface
    constructor: (@weather) ->
      # server address for weather
      @location = []
      super('/api/weathers/', @locations)
      
    show: (location) ->
      super(location).then (weather) =>

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
          @locations = []
          weather_details.forecasts.push(forecast)

        @weather.locations = [weather_details]


]