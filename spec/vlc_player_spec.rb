require 'spec_helper'
describe Sc::VLCPlayer do
  describe "#connect" do

    it "only tries once to start the connection" do
      vlc_client = stub(:vlc_client)
      vlc_client.stub(:connect) do
        unless @raised
          @raised = true
          raise VLC::ConnectionRefused.new
        end
      end

      start_vlc_process = mock(:start_vlc_process, call: nil)
      start_vlc_process.should_receive(:call).once

      player = Sc::VLCPlayer.new(vlc_client, start_vlc_process, double.as_null_object)

      player.connect
    end

    it "raises PlayerNotAvailableError if there's an error when trying to connect" do
      vlc_client = stub(:vlc_client)
      vlc_client.stub(:connect){ raise VLC::ConnectionRefused.new }

      player = Sc::VLCPlayer.new(vlc_client, double.as_null_object, double)

      expect{
        player.connect
      }.to raise_error(Sc::PlayerNotAvailableError)
    end
  end
end
