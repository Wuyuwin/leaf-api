# frozen_string_literal: true

require_relative '../../../spec_helper'

describe 'Test LocationMapper' do
  VCRHelper.setup_vcr

  before do
    VCRHelper.configure_vcr_for('entity_location', 'GOOGLE_TOKEN', CORRECT_SECRETS.GOOGLE_TOKEN)
  end

  after do
    VCRHelper.eject_vcr
  end

  describe 'Test find method' do
    it 'Returns a Location entity for a valid address' do
      location_mapper = Leaf::GoogleMaps::LocationMapper.new(
        Leaf::GoogleMaps::API,
        CORRECT_SECRETS.GOOGLE_TOKEN
      )
      location = location_mapper.find('光明里 300, Hsinchu City, East District')

      _(location).must_be_kind_of Leaf::Entity::Location
      _(location.name).must_be_instance_of String
      _(location.latitude).must_be_instance_of Float
      _(location.longitude).must_be_instance_of Float
      _(location.plus_code).must_be_instance_of String
    end
  end
end
