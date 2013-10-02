require 'spec_helper'

module Sc
  describe Main do
    it "notifies console logger when the player is not available" do
      my_vlc_player = double(:my_vlc_player)
      my_vlc_player.stub(:connect).and_raise(PlayerNotAvailableError)
      VLCPlayer.stub(new: my_vlc_player)

      console_logger = double(:console_logger)
      expect(console_logger).to receive(:player_is_not_available)

      console_logger = ConsoleLogger.stub(new: console_logger)

      Main.pre_block.call
    end
  end
end
