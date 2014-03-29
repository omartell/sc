Feature: Playing tracks
As a regular SoundCloud user
I want to play SoundCloud tracks and playlists
Using their permalinks or urls

@vcr
Scenario: Playing tracks using the permalink
  Given I have the soundcloud track permalink "came-back-haunted-2013"
  When I run play permalink with "nineinchnails/came-back-haunted-2013"
  Then I should see the following now playing track information:
  | track_name               | artist        | duration | id        |
  | came-back-haunted-2013   | nineinchnails | 05:17    | 95453832  |

@vcr
Scenario: Playing tracks using the track permalink url
  Given I have the soundcloud track permalink url for "came-back-haunted-2013"
  When I run play permalink url with "https://soundcloud.com/nineinchnails/came-back-haunted-2013"
  Then I should see the following now playing track information:
  | track_name               | artist        | duration | id        |
  | came-back-haunted-2013   | nineinchnails | 05:17    | 95453832  |

@vcr
Scenario: Playing tracks using the track permalink url
  Given I have the soundcloud track id for "came-back-haunted-2013"
  When I run play id with "95453832"
  Then I should see the following now playing track information:
  | track_name               | artist        | duration | id        |
  | came-back-haunted-2013   | nineinchnails | 05:17    | 95453832  |

@vcr
Scenario: Play soundcloud playlist using the set permalink
  Given I have the soundcloud playlist permalink "definitive-nin-the-singles"
  When I run play playlist permalink with "nineinchnails/definitive-nin-the-singles"
  Then I should see the following now playing track information:
  | track_name               | artist        | duration | id        |
  | down-in-it-1989          | nineinchnails | 05:17    | 95453832  |
  | head-like-a-hole-1989    | nineinchnails | 05:17    | 95453832  |
