resource "grafana_contact_point" "gotify" {
  name = "gotify"

  webhook {
    url         = "${var.gotify_base_url}/message"
    http_method = "POST"

    headers = {
      "X-Gotify-Key" = var.gotify_api_token
    }

    title   = "{{ .CommonLabels.alertname }}"
    message = "{{ .CommonAnnotations.summary }}\n{{ range .Alerts }}{{ .Labels }}\n{{ end }}"
  }
}

resource "grafana_notification_policy" "default" {
  contact_point   = grafana_contact_point.gotify.name
  group_by        = ["alertname"]
  group_wait      = "30s"
  group_interval  = "5m"
  repeat_interval = "4h"
}

resource "grafana_rule_group" "infrastructure" {
  name             = "Infrastructure"
  folder_uid       = grafana_folder.infrastructure.uid
  interval_seconds = 60

  rule {
    name           = "Host Down"
    for            = "5m"
    condition      = "B"
    no_data_state  = "OK"
    exec_err_state = "Alerting"

    annotations = {
      summary = "{{ $labels.host }} has not reported host metrics for 5m."
    }
    labels = {
      severity = "critical"
    }

    # unix exporter's own "up" — goes to 0 the instant Prometheus can't
    # scrape that host's Alloy agent, no need to rely on no-data semantics.
    data {
      ref_id         = "A"
      query_type     = ""
      datasource_uid = grafana_data_source.prometheus.uid
      relative_time_range {
        from = 600
        to   = 0
      }
      model = jsonencode({
        expr    = "min by (host) (up{job=\"integrations/unix\"})"
        instant = true
        refId   = "A"
      })
    }

    data {
      ref_id         = "B"
      query_type     = ""
      datasource_uid = "__expr__"
      relative_time_range {
        from = 0
        to   = 0
      }
      model = jsonencode({
        type       = "threshold"
        expression = "A"
        conditions = [{
          evaluator = { type = "lt", params = [1] }
        }]
        refId = "B"
      })
    }
  }

  rule {
    name           = "Disk Almost Full"
    for            = "10m"
    condition      = "B"
    no_data_state  = "OK"
    exec_err_state = "Alerting"

    annotations = {
      summary = "{{ $labels.host }} filesystem {{ $labels.mountpoint }} is over 90% full."
    }
    labels = {
      severity = "warning"
    }

    # aggregated by (host, mountpoint, fstype, device) — drops the
    # container-id-churn "instance" label so old/new Alloy instances don't
    # produce duplicate alert instances for the same filesystem.
    data {
      ref_id         = "A"
      query_type     = ""
      datasource_uid = grafana_data_source.prometheus.uid
      relative_time_range {
        from = 600
        to   = 0
      }
      model = jsonencode({
        expr    = "max by (host, mountpoint, fstype, device) (100 - ((node_filesystem_avail_bytes{fstype!~\"tmpfs|devtmpfs|overlay|squashfs\"} * 100) / node_filesystem_size_bytes{fstype!~\"tmpfs|devtmpfs|overlay|squashfs\"}))"
        instant = true
        refId   = "A"
      })
    }

    data {
      ref_id         = "B"
      query_type     = ""
      datasource_uid = "__expr__"
      relative_time_range {
        from = 0
        to   = 0
      }
      model = jsonencode({
        type       = "threshold"
        expression = "A"
        conditions = [{
          evaluator = { type = "gt", params = [90] }
        }]
        refId = "B"
      })
    }
  }

  rule {
    name           = "Container Restart Looping"
    for            = "5m"
    condition      = "B"
    no_data_state  = "OK"
    exec_err_state = "Alerting"

    annotations = {
      summary = "Container {{ $labels.name }} on {{ $labels.host }} has restarted more than twice in the last 15m."
    }
    labels = {
      severity = "warning"
    }

    # aggregated by (host, name) only — cAdvisor attaches every docker
    # label as a Prometheus label, which otherwise produces mismatched
    # label sets per container and breaks Grafana's alert result frames.
    data {
      ref_id         = "A"
      query_type     = ""
      datasource_uid = grafana_data_source.prometheus.uid
      relative_time_range {
        from = 900
        to   = 0
      }
      model = jsonencode({
        expr    = "max by (host, name) (changes(container_start_time_seconds{name!=\"\"}[15m]))"
        instant = true
        refId   = "A"
      })
    }

    data {
      ref_id         = "B"
      query_type     = ""
      datasource_uid = "__expr__"
      relative_time_range {
        from = 0
        to   = 0
      }
      model = jsonencode({
        type       = "threshold"
        expression = "A"
        conditions = [{
          evaluator = { type = "gt", params = [2] }
        }]
        refId = "B"
      })
    }
  }
}
