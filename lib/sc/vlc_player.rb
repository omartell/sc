class Sc::VLCPlayer
  attr_reader :vlc_client,  :output_logger

  def initialize(vlc_client, output_logger)
    @vlc_client = vlc_client
    @output_logger = output_logger
  end

  def play_track(track)
    vlc_client.play(track.permalink_url)
  end

  def connect
    @attempts ||= 0
    begin
      @attempts += 1
      vlc_client.server.start
      vlc_client.connect
    rescue VLC::ConnectionRefused => e
      if @attempts == 1
        connect
      else
        raise Sc::PlayerNotAvailableError.new("VLC doesn't seem to be available to connect")
      end
    end
  end

  def play_playlist(playlist)
    playlist.tracks.each do |track|
      add_track_to_playlist(track.permalink)
    end
  end

end
