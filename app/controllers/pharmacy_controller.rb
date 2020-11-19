require 'csv'

class PharmacyController < ApplicationController
  def show
    # prepping the latitude & longitude for the closest_pharma function.
    lat_lon_arr = params[:latlon].split(',')
    lat,lon = lat_lon_arr
    # replacing the semi colons with periods.
    lat[";"] = '.'
    lon[";"] = '.'

    # returns a JSON of the closest pharmacy with properties: name, address, and miles.
    #  to_f => converts srings to a float.
    closest_pharma = get_closest_pharma([lat.to_f, lon.to_f])

    render json: closest_pharma, status: :ok
  end

  private
  def get_closest_pharma(lat_lon_array)
    # @param lat_lon_array => is an array of floats containing the user's coordinates.
    # Geocoder::Calculations.distance_between(pointA, pointB) returns the miles between point A and point B.
    # returns a JSON object with properties => name:string, address:string, miles:float.
    miles = 0
    name, address = "", ""

    # pharmas => is an array of arrays containing each store's information.
    pharmas = CSV.read('app/data/pharmacies.csv')
    # gets rid of the headers row.
    pharmas.slice!(0)

    pharmas.each do |pharmacy|
      if miles.zero?
        miles = Geocoder::Calculations.distance_between(lat_lon_array, [pharmacy[5].to_f, pharmacy[6].to_f])
        name = pharmacy[0]
        address = "#{pharmacy[1]}, #{pharmacy[2]}, #{pharmacy[3]} #{pharmacy[4]}"
      else
        potential_closest_mi = Geocoder::Calculations.distance_between(lat_lon_array, [pharmacy[5].to_f, pharmacy[6].to_f])
        if miles > potential_closest_mi
          miles = potential_closest_mi
          name = pharmacy[0]
          address = "#{pharmacy[1]}, #{pharmacy[2]}, #{pharmacy[3]} #{pharmacy[4]}"
        end
      end
    end

    { name: name.strip, address: address, miles: miles }
  end
end
