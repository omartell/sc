class Sc::ExecutesCommands
  def initialize(soundcloud_client)
    @soundcloud_client = soundcloud_client
  end

  def search(options, search_term, search_results_displayer)
    tracks = @soundcloud_client.search_tracks(search_term)
    search_results_displayer.show_matching_tracks(tracks)
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