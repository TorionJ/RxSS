require 'csv'

class Coordinate < ApplicationRecord
  attr_accessor :latitude, :longitude

  validates :latitude, :longitude, presence: true, numericality: true


  def get_closest_pharma
    # Geocoder::Calculations.distance_between(pointA, pointB) returns the miles between point A and point B.
    # returns a JSON object with properties => name:string, address:string, miles:float.
    miles = -1
    name, address = "", ""

    # pharmas => is an array of arrays containing each store's information.
    pharmas = CSV.read('app/data/pharmacies.csv')
    # gets rid of the headers row.
    pharmas.slice!(0)

    pharmas.each do |pharmacy|
      if miles < 0
        miles = Geocoder::Calculations.distance_between([latitude, longitude], [pharmacy[5], pharmacy[6]])
        name = pharmacy[0]
        address = "#{pharmacy[1]}, #{pharmacy[2]}, #{pharmacy[3]} #{pharmacy[4]}"
      end

      if miles
        potential_closest_mi = Geocoder::Calculations.distance_between([latitude, longitude], [pharmacy[5], pharmacy[6]])
        if miles > potential_closest_mi
          miles = potential_closest_mi
          name = pharmacy[0]
          address = "#{pharmacy[1]}, #{pharmacy[2]}, #{pharmacy[3]} #{pharmacy[4]}"
        end
      end
    end

    { name: name.strip, address: address, miles: miles.round(2) }
  end
end
