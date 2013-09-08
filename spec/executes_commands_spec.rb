require 'spec_helper'

describe "Execute Commands" do
  let(:options){ { t: true } }
  let(:args){ "nineinchnails" }

  it "executes the search command" do
    sc_client = mock(:client)
    subject   = Sc::ExecutesCommands.new(sc_client)
    sc_client
      .should_receive(:search_tracks)
      .with("nineinchnails")
      .and_return(double(:track))

    subject.search(options, args)
  end
end