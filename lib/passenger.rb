require_relative "csv_record"

module RideShare
  class Passenger < CsvRecord
    attr_reader :name, :phone_number, :trips

    def initialize(id:, name:, phone_number:, trips: nil)
      super(id)

      @name = name
      @phone_number = phone_number
      @trips = trips || []
    end

    def add_trip(trip)
      @trips << trip
    end

    def net_expenditures
      if trips == []
        return "This passenger has taken no trips."
      else
        sum = 0
        @trips.each do |trip|
          if trip.cost != nil
            sum += trip.cost
          end
        end
        total_cost = sum
        return total_cost
      end
    end

    def total_time_spent
      if trips == []
        return "This passenger has taken no trips."
      else
        total_time = 0
        @trips.each do |trip|
          if trip.end_time != nil
            total_time += trip.duration_seconds
          end
        end
        return total_time
      end
    end

    private

    def self.from_csv(record)
      return new(
               id: record[:id],
               name: record[:name],
               phone_number: record[:phone_num],
             )
    end
  end
end
