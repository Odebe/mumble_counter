require "socket"

module MumbleCounter
  class Adapter
    def initialize(addr : String, port : Int32 = 64738)
      @socket = UDPSocket.new
      @addr = addr
      @port = port 
    end

    def connect
      @socket.connect(@addr, @port)
    end

    def users_info
      send(ping_message)
      parse_users_info(receive)
    end

    def close
      @socket.close
    end

    private def parse_users_info(resp)
      msg, addr = resp
      bytes = msg.to_slice

      { online: format_number(bytes[12...16]), maximum: format_number(bytes[16...20]) }
    end

    # [0, 1, 0, 2] -> "102"
    private def format_number(bytes)
      arr = bytes.to_a
      index = arr.index { |e| !e.zero? }
      index.is_a?(Nil) ? "0" : arr[index..-1].join("")
    end

    private def ping_message
      "\u{0}\u{0}\u{0}\u{0}\u{12}\u{5}\u{1}\u{5}\u{12}\u{5}\u{1}\u{5}".to_slice
    end

    private def send(req)
      @socket.send(req)
    end

    private def receive
      @socket.receive
    end
  end
end
