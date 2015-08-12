require 'rest-client'
require 'cgi'

module DashingContrib
  module Pingdom
    module Checks
      extend self

      def fetch(credentials, id)
        make_request(credentials, id)
      end

      def summary(credentials)
        checks = make_request(credentials, nil)
        states = { 'up'               => { checks: { }, value: 0 },
                   'down'             => { checks: { }, value: 0 },
                   'unconfirmed_down' => { checks: { }, value: 0 },
                   'unknown'          => { checks: { }, value: 0 },
                   'paused'           => { checks: { }, value: 0 }
                 }

        checks[:checks].each { |check|
          states[check[:status]] = { checks: states[check[:status]][:checks], value: (states[check[:status]][:value] + 1) }
          if check.has_key?(:lasterrortime)
            states[check[:status]][:checks][check[:lasterrortime]] = check[:name]
          elsif check.has_key?(:lasttesttime)
            states[check[:status]][:checks][check[:lasttesttime]] = check[:name]
          end
        }
        return states
      end

      private
      def make_request(credentials, id)
        if ( id.nil? )
          request_url = "https://#{credentials.username}:#{credentials.password}@api.pingdom.com/api/2.0/checks/"
        else
          request_url = "https://#{credentials.username}:#{credentials.password}@api.pingdom.com/api/2.0/checks/#{id}"
        end
        headers = { 'App-Key' => credentials.api_key }
        headers['Account-Email'] = credentials.team_account unless credentials.team_account.empty?
        response = RestClient.get(request_url, headers)
        MultiJson.load response.body, { symbolize_keys: true }
      end
    end
  end
end
