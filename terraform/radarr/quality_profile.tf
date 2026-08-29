resource "radarr_quality_profile" "any" {
  name                     = "Any"
  upgrade_allowed          = false
  cutoff                   = 20
  cutoff_format_score      = 0
  min_format_score         = 0
  min_upgrade_format_score = 1

  language = {
    id   = 1
    name = "English"
  }

  format_items = [
    {
      format = 1
      name   = "Rifftrax"
      score  = -1000
    },
  ]

  quality_groups = [
    {
      qualities = [
        {
          id         = 22
          name       = "BR-DISK"
          resolution = 1080
          source     = "bluray"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 31
          name       = "Remux-2160p"
          resolution = 2160
          source     = "bluray"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 19
          name       = "Bluray-2160p"
          resolution = 2160
          source     = "bluray"
        },
      ]
    },
    {
      id   = 1003
      name = "WEB 2160p"
      qualities = [
        {
          id         = 18
          name       = "WEBDL-2160p"
          resolution = 2160
          source     = "webdl"
        },
        {
          id         = 17
          name       = "WEBRip-2160p"
          resolution = 2160
          source     = "webrip"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 16
          name       = "HDTV-2160p"
          resolution = 2160
          source     = "tv"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 30
          name       = "Remux-1080p"
          resolution = 1080
          source     = "bluray"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 7
          name       = "Bluray-1080p"
          resolution = 1080
          source     = "bluray"
        },
      ]
    },
    {
      id   = 1002
      name = "WEB 1080p"
      qualities = [
        {
          id         = 3
          name       = "WEBDL-1080p"
          resolution = 1080
          source     = "webdl"
        },
        {
          id         = 15
          name       = "WEBRip-1080p"
          resolution = 1080
          source     = "webrip"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 9
          name       = "HDTV-1080p"
          resolution = 1080
          source     = "tv"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 6
          name       = "Bluray-720p"
          resolution = 720
          source     = "bluray"
        },
      ]
    },
    {
      id   = 1001
      name = "WEB 720p"
      qualities = [
        {
          id         = 5
          name       = "WEBDL-720p"
          resolution = 720
          source     = "webdl"
        },
        {
          id         = 14
          name       = "WEBRip-720p"
          resolution = 720
          source     = "webrip"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 4
          name       = "HDTV-720p"
          resolution = 720
          source     = "tv"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 21
          name       = "Bluray-576p"
          resolution = 576
          source     = "bluray"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 20
          name       = "Bluray-480p"
          resolution = 480
          source     = "bluray"
        },
      ]
    },
    {
      id   = 1000
      name = "WEB 480p"
      qualities = [
        {
          id         = 8
          name       = "WEBDL-480p"
          resolution = 480
          source     = "webdl"
        },
        {
          id         = 12
          name       = "WEBRip-480p"
          resolution = 480
          source     = "webrip"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 23
          name       = "DVD-R"
          resolution = 480
          source     = "dvd"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 2
          name       = "DVD"
          resolution = 0
          source     = "dvd"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 1
          name       = "SDTV"
          resolution = 480
          source     = "tv"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 28
          name       = "DVDSCR"
          resolution = 480
          source     = "dvd"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 29
          name       = "REGIONAL"
          resolution = 480
          source     = "dvd"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 27
          name       = "TELECINE"
          resolution = 0
          source     = "telecine"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 26
          name       = "TELESYNC"
          resolution = 0
          source     = "telesync"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 25
          name       = "CAM"
          resolution = 0
          source     = "cam"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 24
          name       = "WORKPRINT"
          resolution = 0
          source     = "workprint"
        },
      ]
    },
  ]
}

resource "radarr_quality_profile" "sd" {
  name                     = "SD"
  upgrade_allowed          = false
  cutoff                   = 20
  cutoff_format_score      = 0
  min_format_score         = 0
  min_upgrade_format_score = 1

  language = {
    id   = 1
    name = "English"
  }

  format_items = [
    {
      format = 1
      name   = "Rifftrax"
      score  = -1000
    },
  ]

  quality_groups = [
    {
      qualities = [
        {
          id         = 21
          name       = "Bluray-576p"
          resolution = 576
          source     = "bluray"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 20
          name       = "Bluray-480p"
          resolution = 480
          source     = "bluray"
        },
      ]
    },
    {
      id   = 1000
      name = "WEB 480p"
      qualities = [
        {
          id         = 8
          name       = "WEBDL-480p"
          resolution = 480
          source     = "webdl"
        },
        {
          id         = 12
          name       = "WEBRip-480p"
          resolution = 480
          source     = "webrip"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 2
          name       = "DVD"
          resolution = 0
          source     = "dvd"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 1
          name       = "SDTV"
          resolution = 480
          source     = "tv"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 28
          name       = "DVDSCR"
          resolution = 480
          source     = "dvd"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 29
          name       = "REGIONAL"
          resolution = 480
          source     = "dvd"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 27
          name       = "TELECINE"
          resolution = 0
          source     = "telecine"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 26
          name       = "TELESYNC"
          resolution = 0
          source     = "telesync"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 25
          name       = "CAM"
          resolution = 0
          source     = "cam"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 24
          name       = "WORKPRINT"
          resolution = 0
          source     = "workprint"
        },
      ]
    },
  ]
}

resource "radarr_quality_profile" "hd_720p" {
  name                     = "HD-720p"
  upgrade_allowed          = false
  cutoff                   = 6
  cutoff_format_score      = 0
  min_format_score         = 0
  min_upgrade_format_score = 1

  language = {
    id   = 1
    name = "English"
  }

  format_items = [
    {
      format = 1
      name   = "Rifftrax"
      score  = -1000
    },
  ]

  quality_groups = [
    {
      qualities = [
        {
          id         = 6
          name       = "Bluray-720p"
          resolution = 720
          source     = "bluray"
        },
      ]
    },
    {
      id   = 1001
      name = "WEB 720p"
      qualities = [
        {
          id         = 5
          name       = "WEBDL-720p"
          resolution = 720
          source     = "webdl"
        },
        {
          id         = 14
          name       = "WEBRip-720p"
          resolution = 720
          source     = "webrip"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 4
          name       = "HDTV-720p"
          resolution = 720
          source     = "tv"
        },
      ]
    },
  ]
}

resource "radarr_quality_profile" "hd_1080p" {
  name                     = "HD-1080p"
  upgrade_allowed          = false
  cutoff                   = 7
  cutoff_format_score      = 0
  min_format_score         = 0
  min_upgrade_format_score = 1

  language = {
    id   = 1
    name = "English"
  }

  format_items = [
    {
      format = 1
      name   = "Rifftrax"
      score  = -1000
    },
  ]

  quality_groups = [
    {
      qualities = [
        {
          id         = 30
          name       = "Remux-1080p"
          resolution = 1080
          source     = "bluray"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 7
          name       = "Bluray-1080p"
          resolution = 1080
          source     = "bluray"
        },
      ]
    },
    {
      id   = 1002
      name = "WEB 1080p"
      qualities = [
        {
          id         = 3
          name       = "WEBDL-1080p"
          resolution = 1080
          source     = "webdl"
        },
        {
          id         = 15
          name       = "WEBRip-1080p"
          resolution = 1080
          source     = "webrip"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 9
          name       = "HDTV-1080p"
          resolution = 1080
          source     = "tv"
        },
      ]
    },
  ]
}

resource "radarr_quality_profile" "ultra_hd" {
  name                     = "Ultra-HD"
  upgrade_allowed          = false
  cutoff                   = 31
  cutoff_format_score      = 0
  min_format_score         = 0
  min_upgrade_format_score = 1

  language = {
    id   = 1
    name = "English"
  }

  format_items = [
    {
      format = 1
      name   = "Rifftrax"
      score  = -1000
    },
  ]

  quality_groups = [
    {
      qualities = [
        {
          id         = 31
          name       = "Remux-2160p"
          resolution = 2160
          source     = "bluray"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 19
          name       = "Bluray-2160p"
          resolution = 2160
          source     = "bluray"
        },
      ]
    },
    {
      id   = 1003
      name = "WEB 2160p"
      qualities = [
        {
          id         = 18
          name       = "WEBDL-2160p"
          resolution = 2160
          source     = "webdl"
        },
        {
          id         = 17
          name       = "WEBRip-2160p"
          resolution = 2160
          source     = "webrip"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 16
          name       = "HDTV-2160p"
          resolution = 2160
          source     = "tv"
        },
      ]
    },
  ]
}

resource "radarr_quality_profile" "hd_720p_1080p" {
  name                     = "HD - 720p/1080p"
  upgrade_allowed          = true
  cutoff                   = 9
  cutoff_format_score      = 0
  min_format_score         = 0
  min_upgrade_format_score = 1

  language = {
    id   = -2
    name = "Original"
  }

  format_items = [
    {
      format = 1
      name   = "Rifftrax"
      score  = -1000
    },
  ]

  quality_groups = [
    {
      qualities = [
        {
          id         = 9
          name       = "HDTV-1080p"
          resolution = 1080
          source     = "tv"
        },
      ]
    },
    {
      id   = 1001
      name = "WEB 720p"
      qualities = [
        {
          id         = 5
          name       = "WEBDL-720p"
          resolution = 720
          source     = "webdl"
        },
        {
          id         = 14
          name       = "WEBRip-720p"
          resolution = 720
          source     = "webrip"
        },
      ]
    },
    {
      id   = 1002
      name = "WEB 1080p"
      qualities = [
        {
          id         = 3
          name       = "WEBDL-1080p"
          resolution = 1080
          source     = "webdl"
        },
        {
          id         = 15
          name       = "WEBRip-1080p"
          resolution = 1080
          source     = "webrip"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 4
          name       = "HDTV-720p"
          resolution = 720
          source     = "tv"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 30
          name       = "Remux-1080p"
          resolution = 1080
          source     = "bluray"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 7
          name       = "Bluray-1080p"
          resolution = 1080
          source     = "bluray"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 6
          name       = "Bluray-720p"
          resolution = 720
          source     = "bluray"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 2
          name       = "DVD"
          resolution = 0
          source     = "dvd"
        },
      ]
    },
    {
      id   = 1003
      name = "WEB 2160p"
      qualities = [
        {
          id         = 18
          name       = "WEBDL-2160p"
          resolution = 2160
          source     = "webdl"
        },
        {
          id         = 17
          name       = "WEBRip-2160p"
          resolution = 2160
          source     = "webrip"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 16
          name       = "HDTV-2160p"
          resolution = 2160
          source     = "tv"
        },
      ]
    },
  ]
}

resource "radarr_quality_profile" "hd_japanese" {
  name                     = "HD - Japanese"
  upgrade_allowed          = true
  cutoff                   = 9
  cutoff_format_score      = 0
  min_format_score         = 0
  min_upgrade_format_score = 1

  language = {
    id   = 8
    name = "Japanese"
  }

  format_items = [
    {
      format = 1
      name   = "Rifftrax"
      score  = -1000
    },
  ]

  quality_groups = [
    {
      qualities = [
        {
          id         = 9
          name       = "HDTV-1080p"
          resolution = 1080
          source     = "tv"
        },
      ]
    },
    {
      id   = 1002
      name = "WEB 1080p"
      qualities = [
        {
          id         = 3
          name       = "WEBDL-1080p"
          resolution = 1080
          source     = "webdl"
        },
        {
          id         = 15
          name       = "WEBRip-1080p"
          resolution = 1080
          source     = "webrip"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 6
          name       = "Bluray-720p"
          resolution = 720
          source     = "bluray"
        },
      ]
    },
    {
      id   = 1001
      name = "WEB 720p"
      qualities = [
        {
          id         = 5
          name       = "WEBDL-720p"
          resolution = 720
          source     = "webdl"
        },
        {
          id         = 14
          name       = "WEBRip-720p"
          resolution = 720
          source     = "webrip"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 4
          name       = "HDTV-720p"
          resolution = 720
          source     = "tv"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 7
          name       = "Bluray-1080p"
          resolution = 1080
          source     = "bluray"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 2
          name       = "DVD"
          resolution = 0
          source     = "dvd"
        },
      ]
    },
  ]
}
