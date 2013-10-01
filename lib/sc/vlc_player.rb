class Sc::VLCPlayer
  attr_reader :vlc_client, :start_vlc_process, :output_logger

  def initialize(vlc_client, start_vlc_process, output_logger)
    @vlc_client        = vlc_client
    @start_vlc_process = start_vlc_process
    @output_logger     = output_logger
  end

  def play_track(track)
    vlc_client.play(track.permalink)
  end

  def connect
    @attempts ||= 0
    begin
      @attempts += 1
      vlc_client.connect
    rescue VLC::ConnectionRefused => e
      if @attempts == 1
        start_vlc_process.call
        sleep(1)
        connect
      else
        raise Sc::PlayerNotAvailableError.new("Your vlc player doesnt seem to be available to connect")
      end
    end
  end

  def play_playlist(playlist)
    playlist.tracks.each do |track|
      add_track_to_playlist(track.permalink)
    end
  end

  def add_track_to_playlist(permalink)

  end
end
