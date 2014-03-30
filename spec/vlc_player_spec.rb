require 'spec_helper'

describe Sc::VLCPlayer do
  describe "#connect" do
    it "only tries once to start the connection" do
      server     = double
      vlc_client = double(:vlc_client, server: server)
      vlc_client.stub(:connect) do
        unless @raised
          @raised = true
          raise VLC::ConnectionRefused.new
        end
      end

      expect(server).to receive(:start).twice

      player = Sc::VLCPlayer.new(vlc_client, double.as_null_object)

      player.connect
    end

    it "raises PlayerNotAvailableError if there's an error when trying to connect" do
      vlc_client = double(:vlc_client, server: double.as_null_object)
      vlc_client.stub(:connect){ raise VLC::ConnectionRefused.new }

      player = Sc::VLCPlayer.new(vlc_client, double)

      expect{
        player.connect
      }.to raise_error(Sc::PlayerNotAvailableError)
    end
  end
end
