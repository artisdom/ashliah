defmodule Ashliah.Protocol.RequestRangeBlockSequence do
  defstruct [:first_message_sequence_number, :last_message_sequence_number]
end

defmodule Ashliah.Protocol.RequestRangeBlockStream do
  defstruct [:starting_stream_offset, :ending_stream_offset]
end