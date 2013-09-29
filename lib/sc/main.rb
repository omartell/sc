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
      executor       = global.fetch(:executor)
      console_logger = Sc::ConsoleLogger.new
      executor.search(options, args.first, console_logger)
    end
  end

  desc 'Play soundcloud tracks'
  command :play do |c|
    c.switch [:p, :permalink], desc: "Play track using the track permalink"
    c.switch [:id, :id], desc: "Play track using the soundcloud track id"
    c.switch [:pl, :playlist], desc: "Play a playlist using the soundcloud set permalink"
    c.action do |global, options, args|
      executor       = global.fetch(:executor)
      console_logger = Sc::ConsoleLogger.new
      if options[:p]
        executor.play_track_permalink(options, args.first, console_logger)
      elsif options[:id]
        executor.play_track_id(options, args.first, console_logger)
      elsif options[:pl]
        executor.play_playlist_permalink(options, args.first, console_logger)
      end
    end
  end

  pre do |global,command,options,args|
    sc_lib         = Soundcloud.new(client_id: '32670b0d40eb8b1b87eac9607e13f843')
    sc_client      = Sc::SoundCloudClient.new(sc_lib)
    player         = Sc::VLCPlayer.new(VLC::Client.new('127.0.0.1', '9000'))
    global[:executor] = Sc::ExecutesCommands.new(sc_client, player)
    true
  end

end
