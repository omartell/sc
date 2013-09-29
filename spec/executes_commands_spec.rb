require 'spec_helper'

describe "Execute Commands" do
  let(:options){ { t: true } }
  let(:args){ "nineinchnails" }
  let(:player){ mock(:player) }

  def build_executes_commands(sc_client, player)
    @commands ||= Sc::ExecutesCommands.new(sc_client, player)
  end

  it "executes the search command" do
    sc_client = mock(:client)
    subject   = build_executes_commands(sc_client, player)
    sc_client
      .should_receive(:search_tracks)
      .with("nineinchnails")
      .and_return(double(:track))

    subject.search(options, args, double.as_null_object)
  end

it "sends the show matching tracks message to the notifier" do
    tracks = [stub]
    sc_client = stub(:client, search_tracks: tracks)
    subject   = build_executes_commands(sc_client, player)

    output = mock

    output.should_receive(:show_matching_tracks).with(tracks)

    subject.search(options, args, output)
  end

  context "Playing Tracks" do
    let(:permalink){
      "nineinchnails/came-back-haunted-2013"
    }
    it "plays the track using the track short name" do
      player     = mock(:player)
      sc_client  = double(:client).as_null_object

      subject   = build_executes_commands(sc_client, player)

      player.should_receive(:play_track_permalink).with(permalink)

      subject.play_track_permalink(options, permalink, double.as_null_object)
    end

    it "gets the track information from the soundcloud client" do
      player     = double(:player).as_null_object
      sc_client  = mock(:client)

      subject   = build_executes_commands(sc_client, player)

      sc_client.should_receive(:get_track_info_from_permalink).with(permalink)

      subject.play_track_permalink(options, permalink, double.as_null_object)
    end

    it "notifies the output object to dispaly the track information" do
      player     = double(:player).as_null_object
      sc_client  = double(:client).as_null_object
      output_logger = mock(:logger)

      subject   = build_executes_commands(sc_client, player)

      output_logger.should_receive(:display_track_information)

      subject.play_track_permalink(options, permalink, output_logger)
    end
  end
end
