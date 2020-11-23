class PharmacyController < ApplicationController
  def show
    # replacing the semi colons with decimals.
    if !params[:lat].include?(';') || !params[:lon].include?(';')
      return render json: { error: 'Latitude and Longitude decimal must be replaced with %3B'}, status: :bad_request
    end

    lat,lon = params[:lat], params[:lon]
    lat[";"],lon[";"] = '.','.'

    pharmacy = Coordinate.new(latitude: lat, longitude: lon)

    render json: pharmacy.get_closest_pharma, status: :ok
  end
end
