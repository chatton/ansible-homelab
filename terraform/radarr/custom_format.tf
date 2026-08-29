resource "radarr_custom_format" "rifftrax" {
  name                                = "Rifftrax"
  include_custom_format_when_renaming = false

  specifications = [
    {
      name           = "RiffTrax"
      implementation = "ReleaseTitleSpecification"
      negate         = false
      required       = true
      value          = ".*(?i)rifftrax.*"
    },
  ]
}
