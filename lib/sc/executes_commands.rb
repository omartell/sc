class Sc::ExecutesCommands
  def initialize(soundcloud_client)
    @soundcloud_client = soundcloud_client
  end

  def search(options, search_term)
    @soundcloud_client.search_tracks(search_term)
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