# use_script_import/script_import_path are managed by ansible instead (see
# roles/portainer_arr/tasks/main.yml, roles/portainer_arr/CLAUDE.md) - the
# released devopsarr/radarr provider doesn't expose these two fields yet.
# A fork adding them (github.com/chatton/terraform-provider-radarr) was tested
# locally via dev_overrides and confirmed working (2026-08-29) - commented out
# below, ready to uncomment once that fork is published/pinned as a release.
resource "radarr_media_management" "current" {
  auto_unmonitor_previously_downloaded_movies = true
  recycle_bin                                 = ""
  recycle_bin_cleanup_days                    = 7
  download_propers_and_repacks                = "preferAndUpgrade"
  create_empty_movie_folders                  = false
  delete_empty_folders                        = false
  file_date                                   = "none"
  rescan_after_refresh                        = "always"
  auto_rename_folders                         = false
  paths_default_static                        = false
  set_permissions_linux                       = false
  chmod_folder                                = "755"
  chown_group                                 = ""
  skip_free_space_check_when_importing        = false
  minimum_free_space_when_importing           = 100
  copy_using_hardlinks                        = true
  # use_script_import                           = true
  # script_import_path                          = "/scripts/import.sh"
  import_extra_files                          = false
  extra_file_extensions                       = "srt"
  enable_media_info                           = true
}
