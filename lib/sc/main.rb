require 'gli'
require 'soundcloud'
require 'vlc-client'

class Sc::Main
  extend GLI::App

  program_desc '**************Totally Awesome ☁☁☁ SoundCloud ☁☁☁ Command Line App**************'

  version "0.0.1"

  desc 'Search sounds, users or playlists to play'
  command :search do |c|
    c.switch [:t, :tracks], desc: "Search for tracks"
    c.action do |global, options, args|
      executor  = global.fetch(:executor)
      tracks_displayer = Sc::TracksDisplayer.new
      executor.search(options, args.first, tracks_displayer)
    end
  end

  pre do |global,command,options,args|
    sc_client         = Soundcloud.new(client_id: '32670b0d40eb8b1b87eac9607e13f843')
    global[:executor] = Sc::ExecutesCommands.new(Sc::SoundCloudClient.new(sc_client))
    true
  end

end