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

  def play_track_permalink_url(options, permalink_url, output)
    track = soundcloud_client.get_track_info_from_permalink_url(permalink_url)
    player.play_track(track)
    output.display_track_information(track)
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
