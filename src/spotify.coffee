# Description
#   grabs an artists top tracks
#
# Configuration:
#   None needed. Uses Spotify Public API and my Last.fm API key. Youre welcome.
#
# Commands:
#   spotify ARTIST NAME - <returns the artists top tracks Spotify URL>
#   jam to ARTIST NAME - <returns the artist top track Spotify URL>
#
# Author:
#   Lucas Moore <hey@thelucasmoore.com>

module.exports = (robot) ->

  robot.hear /spotify (.*)/i, (response) ->
    artistName = response.match[1].toLowerCase()
    if artistName is "hoobastank"
      response.send "Sorry, I only search for music."
    else
      searchName = artistName.replace(" ", "+")
      robot.http("http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=#{searchName}&api_key=66e74ba0c979b3e6f0613f6830fc21a1&format=json")
        .get() (err, res, body) ->
          if err
            response.send "Oh noes! #{err}"
            return
          data = JSON.parse body
          bio = data.artist.bio.summary.split("<a")
          response.send "#{bio[0]}"
          robot.http("https://api.spotify.com/v1/search?q=#{searchName}&type=artist")
            .get() (err, res, body) ->
              if err
                response.send "Oh noes! #{err}"
                return
              data = JSON.parse body
              response.send "#{data.artists.items[0].external_urls.spotify}"
          

  robot.hear /jam to (.*)/i, (response) ->
    artistName = response.match[1]
    searchName = artistName.replace(" ", "+")
    robot.http("https://api.spotify.com/v1/search?q=#{searchName}&type=artist")
      .get() (err, res, body) ->
        if err
          response.send "Oh noes! #{err}"
          return
        data = JSON.parse body
        id = data.artists.items[0].id
        robot.http("https://api.spotify.com/v1/artists/#{id}/top-tracks?country=US")
          .get() (err, res, body) ->
            data = JSON.parse body
            url = data.tracks[0].external_urls.spotify
            artist_name = artistName.charAt(0).toUpperCase() + artistName.slice(1);
            track_name = data.tracks[0].name
            response.send "#{artist_name}'s top hit is #{track_name}.\n#{url}"