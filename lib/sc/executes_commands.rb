class Sc::ExecutesCommands
  attr_reader :player, :soundcloud_client
  def initialize(soundcloud_client, player)
    @soundcloud_client = soundcloud_client
    @player = player
  end

  def search(options, search_term, output)
    tracks = soundcloud_client.search_tracks(search_term)
    output.show_matching_tracks(tracks)
  end

  def play_track_permalink(options, permalink, output)
    track = soundcloud_client.get_track_info_from_permalink(permalink)
    player.play_track(track)
    output.display_track_information(track)
  end

  def play_track_id(options, track_id, output)
    track = soundcloud_client.get_track_info_from_track_id(track_id)
    player.play_track(track)
    output.display_track_information(track)
  end

  def play_playlist_permalink(options, permalink, output)
    playlist = soundcloud_client.get_playlist_info_from_permalink(permalink)
    player.play_playlist(playlist)
    output.display_playlist_information(playlist)
  end
end

class Sc::ConsoleLogger
  def show_matching_tracks(tracks)
    tracks.each do |t|
      puts "#{t.user.permalink}/#{t.permalink}"
      puts "\t duration: #{format_duration(t.duration)}"
      puts "\t id: #{t.id}"
    end
  end

  def display_track_information(track)
    puts "Now playing"
    puts track.permalink
    puts track.user.permalink
    puts format_duration(track.duration)
    puts track.id
  end

  def display_playlist_information(playlist)
    playlist.tracks.each do |track|
      display_track_information(track)
    end
  end

  private

  def format_duration(duration)
    miliseconds_to_minutes(duration)
  end

  def miliseconds_to_minutes(duration)
    Time.at(duration/1000).gmtime.strftime('%R:%S')
  end
end

module Sc
  class PlayerNotAvailableError < StandardError; end;
end


class Sc::SoundCloudClient
  attr_reader :client
  def initialize(client)
    @client = client
  end

  def search_tracks(query)
    client.get("/tracks", q: query)
  end

  def get_track_info_from_track_id(track_id)
    client.get("/tracks/#{track_id}")
  end

  def get_playlist_info_from_permalink(permalink)
    if permalink.scan("sets").first
      resolve_permalink(permalink)
    else
      username, playlist = *permalink.scan(/(.*)\/(.*)/).first
      resolve_permalink("#{username}/sets/#{playlist}")
    end
  end

  def get_track_info_from_permalink(permalink)
    resolve_permalink(permalink)
  end

  private

  def resolve_permalink(permalink)
    client.get("/resolve", url: "http://soundcloud.com/#{permalink}")
  end
end
