# TODO: Write documentation for `MumbleCounter`
require "./mumble_counter/adapter.cr"
require "./mumble_counter/genmon.cr"

module MumbleCounter
  VERSION = "0.1.0"

  class Endpoint
    def call(server_addr : String, port : Int32 = 64738)
      adapter = MumbleCounter::Adapter.new(server_addr, port)
      formatter = MumbleCounter::Genmon.new
  
      begin
        adapter.connect
      rescue exception
        return formatter.connection_error
      end
  
      begin
        users_info = adapter.users_info
      rescue exception
        return formatter.request_error
      end

      adapter.close
      formatter.users_info(users_info)
    end
  end
end

puts MumbleCounter::Endpoint.new.call("server")