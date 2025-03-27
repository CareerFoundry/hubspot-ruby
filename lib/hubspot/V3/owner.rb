# frozen_string_literal: true

module Hubspot
  module V3
    #
    # HubSpot Owners API
    #
    # {https://developers.hubspot.com/docs/reference/api/crm/owners}
    #
    class Owner
      GET_OWNER_PATH    = '/crm/v3/owners/:owner_id' # GET
      GET_OWNERS_PATH   = '/crm/v3/owners' # GET
      CREATE_OWNER_PATH = '/crm/v3/owners' # POST
      UPDATE_OWNER_PATH = '/crm/v3/owners/:owner_id' # PATCH
      DELETE_OWNER_PATH = '/crm/v3/owners/:owner_id' # DELETE

      attr_reader :properties, :owner_id, :email

      def initialize(property_hash)
        @properties = property_hash
        @owner_id   = @properties['id']
        @email      = @properties['email']
      end

      def [](property)
        @properties[property]
      end

      class << self
        def all(include_inactive: false, limit: 100, after: nil)
          path = GET_OWNERS_PATH
          params = {
            limit: limit,
            includeInactive: include_inactive
          }
          params[:after] = after if after

          response = Hubspot::Connection.get_json(path, params)
          response['results'].map { |r| new(r) }
        end

        def find(id, include_inactive: false)
          path = GET_OWNER_PATH.gsub(':owner_id', id.to_s)
          params = {
            includeInactive: include_inactive
          }
          response = Hubspot::Connection.get_json(path, params)
          new(response)
        end

        def find_by_email(email, include_inactive: false)
          path = GET_OWNERS_PATH
          params = {
            email: email,
            includeInactive: include_inactive
          }
          response = Hubspot::Connection.get_json(path, params)
          response['results'].first ? new(response['results'].first) : nil
        end

        def create(properties)
          path = CREATE_OWNER_PATH
          response = Hubspot::Connection.post_json(path, properties)
          new(response)
        end

        def update(id, properties)
          path = UPDATE_OWNER_PATH.gsub(':owner_id', id.to_s)
          response = Hubspot::Connection.patch_json(path, properties)
          new(response)
        end

        def delete(id)
          path = DELETE_OWNER_PATH.gsub(':owner_id', id.to_s)
          Hubspot::Connection.delete_json(path)
        end
      end
    end
  end
end
