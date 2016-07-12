# hubot-spotify-tracks

Use this script to grab an artist's top tracks from Spotify. The bot responds with the URL to stream top tracks, or if you just want to *jam out*, the bot send that artist's top track. 

No authorization is required, it only queries the public Spotify API. So it plays 30 second samples.

See [`src/spotify.coffee`](src/spotify.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-spotify-tracks --save`

Then add **hubot-spotify-tracks** to your `external-scripts.json`:

```json
[
  "hubot-spotify-tracks"
]
```

## Sample Interaction

```
user>> spotify El Ten Eleven
hubot>> https://open.spotify.com/artist/0d1j4VJ7gzAJaDslzmjTF0
user>> jam to beyonce
hubot>> Beyonce's top hit is 7/11.
https://open.spotify.com/track/02M6vucOvmRfMxTXDUwRXu

```

## NPM Module

https://www.npmjs.com/package/hubot-spotify-tracks
