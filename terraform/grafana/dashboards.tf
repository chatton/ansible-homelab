resource "grafana_folder" "infrastructure" {
  title = "Infrastructure"
}

resource "grafana_dashboard" "host_overview" {
  folder = grafana_folder.infrastructure.uid
  config_json = templatefile("${path.module}/dashboards/host-overview.json.tftpl", {
    prometheus_datasource_uid = grafana_data_source.prometheus.uid
  })
}

resource "grafana_dashboard" "docker_containers" {
  folder = grafana_folder.infrastructure.uid
  config_json = templatefile("${path.module}/dashboards/docker-containers.json.tftpl", {
    prometheus_datasource_uid = grafana_data_source.prometheus.uid
    loki_datasource_uid       = grafana_data_source.loki.uid
  })
}
