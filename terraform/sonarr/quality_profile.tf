resource "sonarr_quality_profile" "any" {
  name                     = "Any"
  upgrade_allowed          = true
  cutoff                   = 1002
  cutoff_format_score      = 0
  min_format_score         = 0
  min_upgrade_format_score = 1

  format_items = []

  quality_groups = [
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
          id         = 15
          name       = "WEBRip-1080p"
          resolution = 1080
          source     = "webRip"
        },
        {
          id         = 3
          name       = "WEBDL-1080p"
          resolution = 1080
          source     = "web"
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
          id         = 14
          name       = "WEBRip-720p"
          resolution = 720
          source     = "webRip"
        },
        {
          id         = 5
          name       = "WEBDL-720p"
          resolution = 720
          source     = "web"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 9
          name       = "HDTV-1080p"
          resolution = 1080
          source     = "television"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 4
          name       = "HDTV-720p"
          resolution = 720
          source     = "television"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 2
          name       = "DVD"
          resolution = 480
          source     = "dvd"
        },
      ]
    },
    {
      id   = 1000
      name = "WEB 480p"
      qualities = [
        {
          id         = 12
          name       = "WEBRip-480p"
          resolution = 480
          source     = "webRip"
        },
        {
          id         = 8
          name       = "WEBDL-480p"
          resolution = 480
          source     = "web"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 1
          name       = "SDTV"
          resolution = 480
          source     = "television"
        },
      ]
    },
  ]
}

resource "sonarr_quality_profile" "sd" {
  name                     = "SD"
  upgrade_allowed          = false
  cutoff                   = 1
  cutoff_format_score      = 0
  min_format_score         = 0
  min_upgrade_format_score = 1

  format_items = []

  quality_groups = [
    {
      qualities = [
        {
          id         = 2
          name       = "DVD"
          resolution = 480
          source     = "dvd"
        },
      ]
    },
    {
      id   = 1000
      name = "WEB 480p"
      qualities = [
        {
          id         = 12
          name       = "WEBRip-480p"
          resolution = 480
          source     = "webRip"
        },
        {
          id         = 8
          name       = "WEBDL-480p"
          resolution = 480
          source     = "web"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 1
          name       = "SDTV"
          resolution = 480
          source     = "television"
        },
      ]
    },
  ]
}

resource "sonarr_quality_profile" "hd_720p" {
  name                     = "HD-720p"
  upgrade_allowed          = false
  cutoff                   = 4
  cutoff_format_score      = 0
  min_format_score         = 0
  min_upgrade_format_score = 1

  format_items = []

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
          id         = 14
          name       = "WEBRip-720p"
          resolution = 720
          source     = "webRip"
        },
        {
          id         = 5
          name       = "WEBDL-720p"
          resolution = 720
          source     = "web"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 4
          name       = "HDTV-720p"
          resolution = 720
          source     = "television"
        },
      ]
    },
  ]
}

resource "sonarr_quality_profile" "hd_1080p" {
  name                     = "HD-1080p"
  upgrade_allowed          = false
  cutoff                   = 9
  cutoff_format_score      = 0
  min_format_score         = 0
  min_upgrade_format_score = 1

  format_items = []

  quality_groups = [
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
          id         = 15
          name       = "WEBRip-1080p"
          resolution = 1080
          source     = "webRip"
        },
        {
          id         = 3
          name       = "WEBDL-1080p"
          resolution = 1080
          source     = "web"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 9
          name       = "HDTV-1080p"
          resolution = 1080
          source     = "television"
        },
      ]
    },
  ]
}

resource "sonarr_quality_profile" "ultra_hd" {
  name                     = "Ultra-HD"
  upgrade_allowed          = false
  cutoff                   = 16
  cutoff_format_score      = 0
  min_format_score         = 0
  min_upgrade_format_score = 1

  format_items = []

  quality_groups = [
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
          id         = 17
          name       = "WEBRip-2160p"
          resolution = 2160
          source     = "webRip"
        },
        {
          id         = 18
          name       = "WEBDL-2160p"
          resolution = 2160
          source     = "web"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 16
          name       = "HDTV-2160p"
          resolution = 2160
          source     = "television"
        },
      ]
    },
  ]
}

resource "sonarr_quality_profile" "hd_720p_1080p" {
  name                     = "HD - 720p/1080p"
  upgrade_allowed          = true
  cutoff                   = 9
  cutoff_format_score      = 0
  min_format_score         = 0
  min_upgrade_format_score = 1

  format_items = []

  quality_groups = [
    {
      qualities = [
        {
          id         = 9
          name       = "HDTV-1080p"
          resolution = 1080
          source     = "television"
        },
      ]
    },
    {
      id   = 1002
      name = "WEB 1080p"
      qualities = [
        {
          id         = 15
          name       = "WEBRip-1080p"
          resolution = 1080
          source     = "webRip"
        },
        {
          id         = 3
          name       = "WEBDL-1080p"
          resolution = 1080
          source     = "web"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 4
          name       = "HDTV-720p"
          resolution = 720
          source     = "television"
        },
      ]
    },
    {
      id   = 1001
      name = "WEB 720p"
      qualities = [
        {
          id         = 14
          name       = "WEBRip-720p"
          resolution = 720
          source     = "webRip"
        },
        {
          id         = 5
          name       = "WEBDL-720p"
          resolution = 720
          source     = "web"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 2
          name       = "DVD"
          resolution = 480
          source     = "dvd"
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
          id         = 7
          name       = "Bluray-1080p"
          resolution = 1080
          source     = "bluray"
        },
      ]
    },
    {
      id   = 1003
      name = "WEB 2160p"
      qualities = [
        {
          id         = 17
          name       = "WEBRip-2160p"
          resolution = 2160
          source     = "webRip"
        },
        {
          id         = 18
          name       = "WEBDL-2160p"
          resolution = 2160
          source     = "web"
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
      id   = 1000
      name = "WEB 480p"
      qualities = [
        {
          id         = 12
          name       = "WEBRip-480p"
          resolution = 480
          source     = "webRip"
        },
        {
          id         = 8
          name       = "WEBDL-480p"
          resolution = 480
          source     = "web"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 1
          name       = "SDTV"
          resolution = 480
          source     = "television"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 16
          name       = "HDTV-2160p"
          resolution = 2160
          source     = "television"
        },
      ]
    },
    {
      qualities = [
        {
          id         = 20
          name       = "Bluray-1080p Remux"
          resolution = 1080
          source     = "blurayRaw"
        },
      ]
    },
  ]
}
