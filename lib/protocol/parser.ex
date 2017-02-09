defmodule Ashliah.Protocol.Parser do
  @moduledoc """
    This module provides parsing of the binary data and returning the appropriate struct for
    each part of an incoming UDP transfer
  """
  @vsn 1

  @doc """
    Parse the IEX-TP Header from the binary data passed in

    Returns - 
      Ashliah.Protocol.MessageHeader
  """
  @spec parse_header(binary) :: Ashliah.Protocol.MessageHeader
  def parse_header(data) do
    <<
      version :: size(1),
      reserved :: size(1),
      protocol_id :: size(2),
      channel_id :: size(4),
      session_id :: size(4),
      payload_length :: size(2),
      message_count :: size(2),
      stream_offset :: size(8),
      first_message_sequence_number :: size(8),
      send_time :: size(8)
    >> = data

    %Ashliah.Protocol.MessageHeader{
      version: version,
      protocol_id: protocol_id,
      channel_id: channel_id,
      session_id: session_id,
      payload_length: payload_length,
      message_count: message_count,
      stream_offset: stream_offset,
      first_message_sequence_number: first_message_sequence_number,
      send_time: send_time
    }
  end

  @doc """
    Takes the offset of the data block and gets the message data
    - Returns
        Ashliah.Protocol.MessageBlock
  """
  @spec parse_message_block(binary, integer) :: Ashliah.Protocol.MessageBlock
  def parse_message_block(data, offset) do
    <<
      _ :: size(offset),
      length :: size(2),
      data :: binary 
    >> = data

    %Ashliah.Protocol.MessageBlock {
      length: length,
      data: data
    }
  end

  @doc """
    Parses a heartbeat. A heartbeat in IEX-TP is a Message Header but with only 
    the stream offset and first message sequence number populated (or at least used)

    - Returns:
      Ashliah.Protocol.Heartbeat
  """
  @spc parse_heartbeat(binary) :: Ashliah.Protocol.Heartbeat
  def parse_heartbeat(data) do
      <<
      _ :: size(12),
      0,
      0,
      stream_offset :: size(8),
      first_message_sequence_number :: size(8),
      _ :: size(8)
    >> = data

    %Ashliah.Protocol.Heartbeat{
      stream_offset: stream_offset,
      next_message: first_message_sequence_number
    }
  end

  @doc """
    Parses a retransmission request header. 
    - Returns
      Ashliah.Protocol.RetransmissionRequestHeader
  """
  @spec parse_retransmission_request_header(binary) :: Ashliah.Protocol.RetransmissionRequestHeader
  def parse_retransmission_request_header(data) do
    <<
      version :: size(1),
      request_type :: size(1),
      message_protocol_id :: size(2),
      channel_id :: size(4),
      session_id :: size(4),
      request_range_count :: size(4)
    >> = data

    %Ashliah.Protocol.RetransmissionRequestHeader {
      version: version,
      request_type: request_type,
      message_protocol_id: message_protocol_id,
      channel_id: channel_id,
      session_id: session_id,
      request_range_count: request_range_count
    }
  end

  @doc """
    Parses a request range block that is in a stream form. 
    - Returns 
      Ashliah.Protocol.RequestRangeBlockStream
  """
  @spec parse_request_range_block_stream(binary) :: Ashliah.Protocol.RequestRangeBlockStream
  def parse_request_range_block_stream(data) do
    <<
      start_stream_offset :: size(8),
      end_stream_offset :: size(8)
    >> = data

    %Ashliah.Protocol.RequestRangeBlockStream{
      starting_stream_offset: start_stream_offset,
      ending_stream_offset: end_stream_offset
    }
  end

  @doc """
    Parses a range block that is in a sequence form and not in stream form. This is the same
    logic as parse_request_range_block_stream but just returns a different struct to correspond
    with the range block type

    - Returns 
        Ashliah.Protocol.RequestRangeBlockSequence
  """
  @spec parse_request_range_block_sequence(binary) :: Ashliah.Protocol.RequestRangeBlockSequence
  def parse_request_range_block_sequence(data) do
    <<
      first_message_sequence_number :: size(8),
      last_message_sequence_number :: size(8)
    >> = data

    %Ashliah.Protocol.RequestRangeBlockSequence {
      first_message_sequence_number: first_message_sequence_number,
      last_message_sequence_number: last_message_sequence_number
    }
  end
end