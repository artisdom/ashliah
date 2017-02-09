defmodule Ashliah.Protocol.MessageHeader do
  defstruct [:version, :protocol_id,:channel_id, :session_id, :payload_length, :message_count,
              :stream_offset, :first_message_sequence_number,:send_time]
end