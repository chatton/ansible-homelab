# useScriptImport / scriptImportPath are intentionally NOT managed here - the
# devopsarr provider doesn't expose those two fields yet. They're managed
# idempotently via ansible.builtin.uri in roles/portainer_arr/tasks/main.yml
# instead (see roles/portainer_arr/CLAUDE.md for why). Leaving them out of this
# resource means Terraform never reads or writes them, so the two mechanisms
# can't fight over the same config object.
resource "sonarr_media_management" "current" {
  unmonitor_previous_episodes = false
  hardlinks_copy              = true
  create_empty_folders        = false
  delete_empty_folders        = false
  enable_media_info           = true
  import_extra_files          = false
  set_permissions             = false
  skip_free_space_check       = false
  minimum_free_space          = 100
  recycle_bin_days            = 7
  chmod_folder                = "755"
  chown_group                 = ""
  download_propers_repacks    = "preferAndUpgrade"
  episode_title_required      = "always"
  extra_file_extensions       = "srt"
  file_date                   = "none"
  recycle_bin_path            = ""
  rescan_after_refresh        = "always"
}
