module Graticule #:nodoc:
  module Geocoder #:nodoc:
    
    #  freethepostcode.org (http://www.freethepostcode.org/) is a
    #  free service to convert UK postcodes into geolocation data.
    #
    #     gg = Graticule.service(:FreeThePostcode).new
    #     location = gg.locate 'W1A 1AA'
    #     location.coordinates
    #     #=> [51.52093, -0.13714]
    class FreeThePostcode < Base

      def initialize
        @url = URI.parse 'http://www.freethepostcode.org/geocode'
      end

      def locate(postcode)
        get :postcode => postcode
      end
      
    private

      def prepare_response(response)
        response.split("\n")[1]
      end
      
      def parse_response(response)
        data = response.split
        Location.new(:latitude => data[0].to_f, :longitude => data[1].to_f, :precision => :unknown)
      end

      def check_error(response)
        raise AddressError, 'unknown address' if response.blank?
      end
      
    end
  end
end
