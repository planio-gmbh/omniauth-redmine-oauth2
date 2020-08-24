# frozen_string_literal: true

require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class RedmineOauth2 < OmniAuth::Strategies::OAuth2

      USER_INFO_PATH = "users/current.json"

      option :name, "redmine_oauth2"

      option :client_options, {
        site: "https://redmine.example.org",
        authorize_url: "/oauth/authorize",
        token_url: "/oauth/token"
      }

      uid { raw_info["id"] }

      info do
        {
          email: email,
          login: raw_info["login"],
          last_name: raw_info["lastname"],
          first_name: raw_info["firstname"]
        }
      end

      extra do
        { raw_info: raw_info, scope: scope }
      end

      def email
        raw_info['mail']
      end

      def scope
        access_token['scope']
      end

      def raw_info
        access_token.options[:mode] = :header
        @raw_info ||= access_token.get(USER_INFO_PATH).parsed['user']
      end

      private

      # https://github.com/omniauth/omniauth-oauth2/issues/81
      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

