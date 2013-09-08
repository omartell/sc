require 'spec_helper'

describe "Execute Commands" do
  it "executes the search command" do
    sc_client  = mock(:client)
    subject = ExecutesCommands.new(sc_client)
    options = { t: true }
    args    = ["nineinchnails"]

    sc_client
      .should_receive(:search)
      .with("nineinchnails")
      .and_return(double(:track))

    subject.search(options, args)
  end
end