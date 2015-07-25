class Api::WeathersController < ApplicationController
  def show
    render json: get_weather
  end

 private

  def get_weather
    client = YahooWeather::Client.new
    @weather = client.fetch_by_location(get_location)
    @weather.blank? ? client.fetch_by_location('London') : @weather
  end

  def get_location
    location = params[:id] == 'home' ? request.location.city : params[:id]
    location.blank? ? 'London' : location
  end

end
