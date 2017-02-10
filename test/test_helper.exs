ExUnit.start()


defmodule AshliahTest.Helpers do
  @doc """
  Values:

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
  def create_multicast_pub_header do
    << 01, 
      00, 
      02, 80, 
      01, 00, 00, 00, 
      00, 00, 87, 42, 
      58, 00, 
      02, 00, 
      140, 166, 21, 00, 00, 00, 00, 00,
      202, 195, 00, 00, 00, 00, 00, 00,
      236, 45, 194, 20, 96, 86, 109, 14
    >>
  end
end
