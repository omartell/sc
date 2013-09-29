class Sc::ExecutesCommands
  def initialize(soundcloud_client, player)
    @soundcloud_client = soundcloud_client
    @player = player
  end

  def search(options, search_term, output)
    tracks = @soundcloud_client.search_tracks(search_term)
    output.show_matching_tracks(tracks)
  end

  def play_track_permalink(options, permalink, output)
    @player.play_track_permalink(permalink)
    track_information = @soundcloud_client.get_track_info_from_permalink(permalink)
    output.display_track_information(track_information)
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

  private

  def format_duration(duration)
    miliseconds_to_minutes(duration)
  end

  def miliseconds_to_minutes(duration)
    Time.at(duration/1000).gmtime.strftime('%R:%S')
  end
end

class Sc::VLCPlayer
  def initialize(vlc_client)
    @vlc_client = vlc_client
  end

  def play_track_permalink(permalink)

  end
end

class Sc::SoundCloudClient
  def initialize(client)
    @client = client
  end

  def search_tracks(query)
    @client.get("/tracks", q: query)
  end

  def get_track_info_from_permalink(permalink)
    @client.get("/resolve", url: "http://soundcloud.com/#{permalink}")
  end
end
