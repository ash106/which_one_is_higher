require 'net/http'

class Elevation

  def get_elevation_for(ip_info)
    uri = URI("http://maps.googleapis.com/maps/api/elevation/json?locations=#{ip_info['latitude']},#{ip_info['longitude']}&sensor=false")
    data = Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request
    end
    elevation_info = JSON.parse(data.body)
    elevation = elevation_info['results'].first
    elevation_feet = elevation['elevation'] * 3.280839895
    elevation.merge('elevation_feet' => elevation_feet)
  end

end