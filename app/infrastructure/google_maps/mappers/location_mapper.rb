# frozen_string_literal: true

module Leaf
  module GoogleMaps
    # Class to map the data from google maps api to the Trip entity
    class LocationMapper
      def initialize(gateway_class, token)
        @token = token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@token)
      end

      def find(address)
        data = @gateway.geocoding(address)
        plus_code = @gateway.plus_code(address)
        DataMapper.new(data, plus_code).build_entity
      end

      # This class maps the response data from Google Maps API to a Location entity.
      # It extracts necessary information such as name, latitude, and longitude.
      class DataMapper
        def initialize(data, plus_code)
          @data = data
          @plus_code = plus_code
        end

        def build_entity
          Leaf::Entity::Location.new(
            id: nil,
            name: name,
            latitude: latitude,
            longitude: longitude,
            plus_code: plus_code
          )
        end

        def name
          @data['results'][0]['formatted_address']
        end

        def latitude
          @data['results'][0]['geometry']['location']['lat']
        end

        def longitude
          @data['results'][0]['geometry']['location']['lng']
        end

        def plus_code
          @plus_code['plus_code']['global_code']
        end
      end
    end
  end
end
