# TODO: Write documentation for `MumbleCounter`
require "./mumble_counter/adapter.cr"
require "./mumble_counter/genmon.cr"

module MumbleCounter
  VERSION = "0.1.0"

  class Processor

    class AddrEmptyError < Exception; end

    @argv : Array(String)

    def initialize(argv : Array(String))
      @argv = argv
    end

    # TODO: refactor, lol
    def call
      vars = variables
      raise AddrEmptyError.new("server address is empty") unless vars["server"]?
      vars["port"] = "64738" unless vars["port"]?
      vars
    end

    private def variables
      @argv.each_with_object({} of String => String) do |s, result|
        key, value = s.split("=")
        result[key] = value
      end
    end
  end

  class Endpoint
    def call(server_addr : String, port : Int32 = 64738)
      adapter = MumbleCounter::Adapter.new(server_addr, port.to_i)
      formatter = MumbleCounter::Genmon.new
  
      begin
        adapter.connect
      rescue exception
        # TODO: rescue custom error
        adapter.close
        return formatter.connection_error
      end
  
      begin
        users_info = adapter.users_info
      rescue exception
        # TODO: rescue custom error
        adapter.close
        return formatter.request_error
      end

      adapter.close
      formatter.users_info(users_info)
    end
  end
end

begin
  params = MumbleCounter::Processor.new(ARGV).call
  # TODO: pass formatter as argument in enpoint
  puts MumbleCounter::Endpoint.new.call(params["server"], params["port"].to_i)
rescue ex : MumbleCounter::Processor::AddrEmptyError
  puts "<txt><span weight='Bold' fgcolor='Red'>SERVER ADDR IS EMPTY</span></txt>"
end