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
