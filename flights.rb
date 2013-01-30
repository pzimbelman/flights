require 'sinatra'
require_relative 'flight_schedule'

get '/' do
  "This is a little app for Alison!"
end

get '/arriving_to/:airport_code' do
  @json = FlightSchedule.new(ENV['FLIGHT_APP_ID'], ENV['FLIGHT_APP_KEY']).flights_direct_to(params[:airport_code])
  @flights = @json["flights"].sort_by { |x| x["departureAirportFsCode"] }
  haml :index
end

get '/departing_from/:airport_code' do
  @json = FlightSchedule.new(ENV['FLIGHT_APP_ID'], ENV['FLIGHT_APP_KEY']).flights_direct_from(params[:airport_code])
  @flights = @json["flights"].sort_by { |x| x["departureAirportFsCode"] }
  haml :index
end
