
module MumbleCounter
  class Genmon
    def users_info(data : NamedTuple(online: String, maximum: String))
      "<txt>#{data[:online]}/#{data[:maximum]}</txt>"
    end

    def request_error
      "<txt><span weight='Bold' fgcolor='Red'>REQERR</span></txt>"
    end

    def connection_error
      "<txt><span weight='Bold' fgcolor='Red'>CONERR</span></txt>"
    end
  end
end
