defmodule AshliahTest do
  use ExUnit.Case
  doctest Ashliah

  @doc """
    Version: 1
    Reserved: 0
    Message Protocol ID: 640
    Channel: 1
    Session ID: 34626
    Message Count: 2
    Stream Offset: 2,205,234
    First Sequence Number: 50122
    Send Time: 2016-8-23 15:30:32.572839404
  """
  test "the IEX-TP Multicast Header" do
    data = AshliahTest.Helpers.create_multicast_pub_header
    header = Ashliah.Protocol.Parser.parse_header(data) 

    ## Assertions
    assert(header.version == 1)
    assert(header.protocol_id == 640)
    assert(header.channel_id == 1)
    assert(header.session_id == 34626)
    assert(header.payload_length == 88)
    assert(header.message_count == 2)
    assert(header.stream_offset == 2205234)
    assert(header.first_message_sequence_number == 50122)
    assert(header.send_time == "2016-8-23 15:30:32.572839404")
  end
end