class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  def index
  end

  def show
    client = YahooWeather::Client.new
    location = request.location.city
    location = 'xfvghj' if location.blank?
    @weather = client.fetch_by_location(location)
    @weather = client.fetch_by_location('London') if @weather.blank?
    @weather_url = @weather.doc['image']['url']

  end

  def delete
    redirect_to destroy_user_session_path
  end
end
