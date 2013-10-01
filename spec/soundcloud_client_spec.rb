require 'spec_helper'

describe Sc::SoundCloudClient do
  context "playlists" do
    it "inserts sets in the url before sending the request to url if it's not already there" do
      sc_client = mock(:client)

      wrapper = Sc::SoundCloudClient.new(sc_client)

      sc_client
        .should_receive(:get)
        .with("/resolve", url: "http://soundcloud.com/nineinchnails/sets/definitive-nin-the-singles")

      wrapper.get_playlist_info_from_permalink("nineinchnails/definitive-nin-the-singles")
    end
  end
end
