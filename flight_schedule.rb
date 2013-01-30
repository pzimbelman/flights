require 'time'
require 'json'
require 'net/https'

class FlightSchedule
  def initialize(app_id, app_key)
    @app_id = app_id
    @app_key = app_key
  end

  def flights_direct_from(airport_code)
    request_to(from_url(airport_code))
  end

  def flights_direct_to(airport_code)
    request_to(to_url(airport_code))
  end

  private
  def request_to(url)
    response = `curl -s "#{url}"`
    JSON.parse(response)
  end

  def from_url(from_airport)
    date = Date.today
    date_str = "#{date.year}/#{date.month}/#{date.day}"
    "https://api.flightstats.com/flex/connections/rest/v1/json/direct/from/#{from_airport}/departing/#{date_str}?appId=#{@app_id}&appKey=#{@app_key}&serviceType=PASSENGER_ONLY"
  end

  def to_url(to_airport)
    date = Date.today
    date_str = "#{date.year}/#{date.month}/#{date.day}"
    "https://api.flightstats.com/flex/connections/rest/v1/json/direct/to/#{to_airport}/arriving/#{date_str}?appId=#{@app_id}&appKey=#{@app_key}&serviceType=PASSENGER_ONLY"
  end
end
