module Api
  module V1
    class ApiController < ::ApplicationController
      protect_from_forgery with: :null_session

      private
      def current_resource_owner
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
