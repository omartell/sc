class Sc::ExecutesCommands
  def initialize(soundcloud_client, player)
    @soundcloud_client = soundcloud_client
    @player = player
  end

  def search(options, search_term, search_results_displayer)
    tracks = @soundcloud_client.search_tracks(search_term)
    search_results_displayer.show_matching_tracks(tracks)
  end

  def play(options, arg)
    @player.play_track_permalink(arg)
  end
end

class Sc::TracksDisplayer
  def show_matching_tracks(tracks)
    tracks.each do |t|
      puts "#{t.user.permalink}/#{t.permalink}"
      puts "\t duration: #{miliseconds_to_minutes(t.duration)}"
      puts "\t id: #{t.id}"
    end
  end

  private

  def miliseconds_to_minutes(duration)
    Time.at(duration/1000).gmtime.strftime('%R:%S')
  end
end

class Sc::SoundCloudClient
  def initialize(client)
    @client = client
  end

  def search_tracks(query)
    @client.get("/tracks", q: query)
  end
end