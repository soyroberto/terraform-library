# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    spotify = {
      version = "~> 0.2.6"
      source  = "conradludgate/spotify"
    }
  }
}

variable "compositor" {
  type    = list(string)
  default = ["Johann Sebastian Bach", "Ludwig van Beethoven", "Pyotr Ilyich Tchaikovsky"]
}

provider "spotify" {
  api_key = var.spotify_api_key
}

data "spotify_search_track" "by_artist" {
  for_each = { for artist in var.compositor : artist => artist }
  artist = each.value
}

resource "spotify_playlist" "playlist" {
  name        = "Terraform Summer Playlist"
  description = "Creada por @soyroberto c/Terraform"
  public      = true

  tracks = flatten([
    for artist, track_data in data.spotify_search_track.by_artist : [
      for track in track_data.tracks : track.id
    ]
  ])
}
