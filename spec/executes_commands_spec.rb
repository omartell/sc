require 'spec_helper'

describe "Execute Commands" do

  let(:player){ double(:player) }
  let(:sc_client){ double(:sc_client) }
  let(:output_logger){ double(:output_logger) }
  let(:executes_commands){ Sc::ExecutesCommands.new(sc_client, player) }

  context "Searching for tracks" do
    it "executes the search command" do
      expect(sc_client).to receive(:search_tracks).with("nineinchnails")

      executes_commands.search({}, "nineinchnails", output_logger.as_null_object)
    end

    it "sends the show matching tracks message to the notifier" do
      tracks = [double(:track)]
      sc_client.stub(search_tracks: tracks)

      expect(output_logger).to receive(:show_matching_tracks).with(tracks)

      executes_commands.search({}, "nineinchnails", output_logger)
    end
  end

  context "Playing tracks using the permalink url" do
    let(:permalink_url){
      "https://soundcloud.com/nineinchnails/came-back-haunted-2013"
    }

    it "sends the play track from permalink url message to the player" do
      sc_client.as_null_object

      expect(player).to receive(:play_track)

      executes_commands.play_track_permalink_url({}, permalink_url, output_logger.as_null_object)
    end

    it "send get_track_info_from_permalink_url message to the soundcloud_client" do
      player.as_null_object

      expect(sc_client).to receive(:get_track_info_from_permalink_url)

      executes_commands.play_track_permalink_url({}, permalink_url, output_logger.as_null_object)
    end

    it "outputs the track information" do
      player.as_null_object
      sc_client.as_null_object

      expect(output_logger).to receive(:display_track_information)

      executes_commands.play_track_permalink_url({}, permalink_url, output_logger)
    end
  end

  context "Playing tracks using the permalink" do

    let(:permalink){
      "nineinchnails/came-back-haunted-2013"
    }

    it "plays the track using the track short name" do
      sc_client.as_null_object

      expect(player).to receive(:play_track)

      executes_commands.play_track_permalink({}, permalink, output_logger.as_null_object)
    end

    it "gets the track information from the soundcloud client" do
      player.as_null_object

      expect(sc_client).to receive(:get_track_info_from_permalink).with(permalink)

      executes_commands.play_track_permalink({}, permalink, output_logger.as_null_object)
    end

    it "notifies the output object to display the track information" do
      player.as_null_object
      sc_client.as_null_object

      expect(output_logger).to receive(:display_track_information)

      executes_commands.play_track_permalink({}, permalink, output_logger)
    end
  end
end
