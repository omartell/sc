require 'spec_helper'

describe "Execute Commands" do
  let(:options){ { t: true } }
  let(:args){ "nineinchnails" }
  let(:player){ mock(:player) }

  it "executes the search command" do
    sc_client = mock(:client)
    subject   = Sc::ExecutesCommands.new(sc_client, player)
    sc_client
      .should_receive(:search_tracks)
      .with("nineinchnails")
      .and_return(double(:track))

    subject.search(options, args, double.as_null_object)
  end

it "sends the show matching tracks message to the notifier" do
    tracks = [stub]
    sc_client = stub(:client, search_tracks: tracks)
    subject   = Sc::ExecutesCommands.new(sc_client, player)

    displayer = mock

    displayer.should_receive(:show_matching_tracks).with(tracks)

    subject.search(options, args, displayer)
  end

  context "Playing Tracks" do
    it "plays the track using the track short name" do
      player = mock(:player)
      sc_client  = stub(:client)
      track_name = "came-back-haunted-2013"

      subject = Sc::ExecutesCommands.new(sc_client, player)

      player.should_receive(:play_track_permalink).with("came-back-haunted-2013")

      subject.play(options, "came-back-haunted-2013")
    end
  end
end