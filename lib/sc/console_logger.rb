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

  def player_is_not_available
    puts "Your vlc player process doesn't seem to be running :("
  end

  private

  def format_duration(duration)
    miliseconds_to_minutes(duration)
  end

  def miliseconds_to_minutes(duration)
    Time.at(duration/1000).gmtime.strftime('%R:%S')
  end
end
