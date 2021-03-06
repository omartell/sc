Feature: SoundCloud Track Search
  As a regular SoundCloud user
  I want to search for particular tracks
  So that I can play them later

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

