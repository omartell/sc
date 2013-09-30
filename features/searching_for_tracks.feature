Feature: SoundCloud Track Search
  As a regular SoundCloud user
  I want to search for particular tracks

@vcr
Scenario: Searching with the artist name
  Given some "Nine Inch Nails" tracks exist in SoundCloud
  When I search using the term "nineinchnails"
  Then I should see the following track information:
  | track_name                    | artist        | duration | id        |
  | came-back-haunted-2013        | nineinchnails | 05:17    | 95453832  |
  | echoplex-2008                 | nineinchnails | 04:45    | 95440317  |
  | every-day-is-exactly-the-same | nineinchnails | 04:50    | 95440311  |
  | the-perfect-drug-1997         | nineinchnails | 05:15    | 95440302  |
  | closer-1994                   | nineinchnails | 06:13    | 95440298  |

@vcr
Scenario: Playing tracks using the permalink
  Given I have the soundcloud track permalink "came-back-haunted-2013"
  When I run play permalink with "nineinchnails/came-back-haunted-2013"
  Then I should see the following now playing track information:
  | track_name               | artist        | duration | id        |
  | came-back-haunted-2013   | nineinchnails | 05:17    | 95453832  |

@vcr
Scenario: Playing tracks using the track id
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
