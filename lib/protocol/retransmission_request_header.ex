defmodule Ashliah.Protocol.RetransmissionRequestHeader do
  defstruct [:version, :request_type, :message_protocol_id, :channel_id, :session_id, 
              :request_range_count]
end