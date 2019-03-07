require_relative "csv_record"
# require_relative "passenger"
# require_relative "trip"
# require_relative "trip_dispatcher"
require "pry"

module RideShare
  class Driver < CsvRecord
    attr_reader :id, :name, :vin, :status, :trips

    def initialize(id:, name:, vin:, status: :AVAILABLE, trips: nil)
      super(id)
      @name = name
      raise ArgumentError if vin.length != 17
      @vin = vin
      @status = status
      #   binding.pry
      if status == :AVAILABLE
      elsif status == :UNAVAILABLE
      else
        raise ArgumentError
      end
      @trips ||= []
    end

    def self.from_csv(record)
      return new(
               id: record[:id],
               name: record[:name],
               vin: record[:vin],
               status: record[:status].to_sym,
             )
    end

    def add_trip(trip)
      @trips << trip
    end

    def average_rating
      sum_rating = 0
      if trips.length == 0
        return 0
      end
      trips.each do |trip|
        sum_rating += trip.rating
      end
      return sum_rating.to_f / trips.count
    end

    def driver_trip_status_after_trip_request(trip)
      add_trip(trip)
      @status = :UNAVAILABLE
    end

    def total_revenue
      sum_revenue = 0
      if trips.length == 0
        return 0
      end
      trips.each do |trip|
        sum_revenue += (trip.cost - 1.65) * 0.8
      end
      return sum_revenue
    end
  end
end
