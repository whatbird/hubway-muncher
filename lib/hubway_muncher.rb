require 'httparty'

class HubwayMuncher
  include HTTParty
  base_uri 'thehubway.com'

  def self.fetch
    get '/data/stations/bikeStations.xml'
  end

  def self.stations
    (@data ||= fetch).first.last['station'].map{|station| HubwayStation.new station}
  end
end

class HubwayStation < Hash
  def initialize data
    data.each do |k,v|
      self[k] = v
      self.class.send(:define_method, k, Proc.new {eval "self['#{k}'].to_s"})
    end
  end
end
