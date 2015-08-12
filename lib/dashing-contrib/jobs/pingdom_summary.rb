require 'dashing-contrib/bottles/pingdom'

module DashingContrib
  module Jobs
    module PingdomSummary
      extend DashingContrib::RunnableJob

      def self.metrics(options)
        client = DashingContrib::Pingdom::Client.new(
          username: options[:username],
          password: options[:password],
          api_key:  options[:api_key],
          team_account: options[:team_account]
        )

        status   = client.summary()
        sum_status = 'ok'
        sum_total = status["up"][:value] +
                    status["paused"][:value] +
                    status["unconfirmed_down"][:value] +
                    status["down"][:value] +
                    status["unknown"][:value] 
        sum_ok = status["up"][:value] + status["paused"][:value]
        sum_warn = status["unknown"][:value]
        sum_crit = status["down"][:value] + status["unconfirmed_down"][:value]
        sum_status = 'warning' if sum_warn > 0
        sum_status = 'critical' if sum_crit > 0

        tofind = options[:list_top] || 3
        list = Array.new

 	stateMap = { 'up' => 'ok',
                     'paused' => 'warning',
                     'unknown' => 'warning',
                     'down' => 'critical',
                     'unconfirmed_down' => 'critical' }

        repStates = ["down","unconfirmed_down","unknown","paused"]
        repStates.insert(-1, "up") if options[:include_up] || false
        repStates.each { |state| 
          if tofind > 0
            touse =  status[state][:checks].keys.sort.take(tofind)
            tofind = tofind - touse.size
            touse.each { |key|
              list.concat( [ { state: stateMap[state], label: status[state][:checks][key] } ] )
            }
          end
        }

        # returns this dataset
        {
          status: sum_status,
          total: sum_total,
          ok: sum_ok,
          error: sum_crit,
          up:  status["up"][:value],
          down:  status["down"][:value],
          unknown:  status["unknown"][:value],
          paused:  status["paused"][:value],
          unconfirmed_down:  status["unconfirmed_down"][:value],
          items: list,
        }
      end

      def self.validate_state(metrics, options = {})
        return DashingContrib::RunnableJob::CRITICAL if metrics[:status] == 'critical'
        return DashingContrib::RunnableJob::WARNING if metrics[:status] == 'warning'
        DashingContrib::RunnableJob::OK
      end

    end
  end
end
