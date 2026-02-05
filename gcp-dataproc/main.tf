locals {

}

resource "google_dataproc_autoscaling_policy" "asp" {
  policy_id = var.cluster_name
  project   = var.project_id
  location  = var.region

  worker_config {
    max_instances = 2
    min_instances = 2
    weight        = 1.0

  }

  secondary_worker_config {
    max_instances = var.secondary_worker_config.max_instances
    min_instances = var.secondary_worker_config.min_instances
    weight        = var.secondary_worker_config.weight
  }

  basic_algorithm {
    cooldown_period = var.basic_algorithm.cooldown_period

    yarn_config {
      graceful_decommission_timeout = var.basic_algorithm.yarn_config.graceful_decommission_timeout
      scale_down_factor             = var.basic_algorithm.yarn_config.scale_down_factor
      scale_up_factor               = var.basic_algorithm.yarn_config.scale_up_factor
    }
  }

}

## entry point for dataproc cluster creation
resource "google_dataproc_cluster" "gce_based_cluster" {
  name    = var.cluster_name
  region  = var.region
  project = var.project_id
  labels  = var.labels

  cluster_config {

    # The bucket for storing cluster staging data - this will get automatically created
    staging_bucket = google_storage_bucket.dataproc_staging_bucket.name
    temp_bucket    = google_storage_bucket.dataproc_temp_bucket.name

    autoscaling_config {
      policy_uri = google_dataproc_autoscaling_policy.asp.name
    }

    endpoint_config {
      enable_http_port_access = true
    }

    gce_cluster_config {
      zone                   = var.zone
      subnetwork             = var.subnetwork
      service_account        = var.service_account
      service_account_scopes = var.service_account_scopes

      tags = var.tags

      metadata = {
        env : var.env
        hashicorp-vault-addr : local.vault_addr
        hashicorp-vault-role : var.vault_role
      }

      internal_ip_only = false
    }

    dynamic "lifecycle_config" {
      for_each = var.enable_lifecycle_config ? [1] : []
      content {
        idle_delete_ttl  = var.idle_delete_ttl
        auto_delete_time = timeadd(timestamp(), var.auto_delete_time)
      }
    }


    master_config {
      num_instances = var.master_count
      machine_type  = var.master_machine_type
      disk_config {
        boot_disk_type    = "pd-balanced"
        boot_disk_size_gb = 1000
      }
      image_uri = var.image_uri
    }

    worker_config {
      num_instances = var.worker_count
      machine_type  = var.worker_machine_type
      disk_config {
        boot_disk_type    = "pd-balanced"
        boot_disk_size_gb = 1000
      }
      image_uri = var.image_uri
    }

    preemptible_worker_config {
      num_instances = var.secondary_worker_count
      disk_config {
        boot_disk_type    = "pd-balanced"
        boot_disk_size_gb = 1000
      }
      preemptibility = "NON_PREEMPTIBLE"

    }

    # initialization_action {

    # }
    # initialization_action {
    # }

    software_config {
      image_version       = var.image_version
      optional_components = ["JUPYTER"]

      ## this is the same across environments, so we can hardcode it
      override_properties = var.override_properties
    }

    dataproc_metric_config {
      metrics {
        metric_source    = "HDFS"
        metric_overrides = var.metric_override
      }
    }
  }
}
