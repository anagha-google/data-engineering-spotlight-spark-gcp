#############################################################################################################################################################
# About
# In this script, we will -
# 1. Apply necessary updates to organization policies
# 2. Enable google APIs for the Google Cloud services we will use in the demo
#############################################################################################################################################################

# The following are the demo specific org policy updates
resource "google_project_organization_policy" "orgPolicyUpdate_disableSerialPortLogging" {
  project     = var.project_id
  constraint = "compute.disableSerialPortLogging"
  boolean_policy {
    enforced = false
  }
}

resource "google_project_organization_policy" "orgPolicyUpdate_requireOsLogin" {
  project     = var.project_id
  constraint = "compute.requireOsLogin"
  boolean_policy {
    enforced = false
  }
}

resource "google_project_organization_policy" "orgPolicyUpdate_requireShieldedVm" {
  project     = var.project_id
  constraint = "compute.requireShieldedVm"
  boolean_policy {
    enforced = false
  }
}

resource "google_project_organization_policy" "orgPolicyUpdate_vmCanIpForward" {
  project     = var.project_id
  constraint = "compute.vmCanIpForward"
  list_policy {
    allow {
      all = true
    }
  }
}

resource "google_project_organization_policy" "orgPolicyUpdate_vmExternalIpAccess" {
  project     = var.project_id
  constraint = "compute.vmExternalIpAccess"
  list_policy {
    allow {
      all = true
    }
  }
}

resource "google_project_organization_policy" "orgPolicyUpdate_restrictVpcPeering" {
  project     = var.project_id
  constraint = "compute.restrictVpcPeering"
  list_policy {
    allow {
      all = true
    }
  }
}

/*******************************************
Introducing sleep to minimize errors from
dependencies having not completed
********************************************/
resource "time_sleep" "sleep_after_org_policy_updates" {
  create_duration = "120s"
  depends_on = [
    google_project_organization_policy.orgPolicyUpdate_disableSerialPortLogging,
    google_project_organization_policy.orgPolicyUpdate_requireOsLogin,
    google_project_organization_policy.orgPolicyUpdate_requireShieldedVm,
    google_project_organization_policy.orgPolicyUpdate_vmCanIpForward,
    google_project_organization_policy.orgPolicyUpdate_vmExternalIpAccess,
    google_project_organization_policy.orgPolicyUpdate_restrictVpcPeering
  ]
}

resource "google_project_service" "enable_orgpolicy_google_apis" {
  project = var.project_id
  service = "orgpolicy.googleapis.com"
  disable_dependent_services = true
  depends_on = [
    time_sleep.sleep_after_org_policy_updates
  ]
}

resource "google_project_service" "enable_compute_google_apis" {
  project = var.project_id
  service = "compute.googleapis.com"
  disable_dependent_services = true
  depends_on = [
    time_sleep.sleep_after_org_policy_updates
  ]
}

resource "google_project_service" "enable_container_google_apis" {
  project = var.project_id
  service = "container.googleapis.com"
  disable_dependent_services = true
  depends_on = [
    time_sleep.sleep_after_org_policy_updates
  ]
}

resource "google_project_service" "enable_containerregistry_google_apis" {
  project = var.project_id
  service = "containerregistry.googleapis.com"
  disable_dependent_services = true
  depends_on = [
    time_sleep.sleep_after_org_policy_updates
  ]
}

resource "google_project_service" "enable_dataproc_google_apis" {
  project = var.project_id
  service = "dataproc.googleapis.com"
  disable_dependent_services = true
  depends_on = [
    time_sleep.sleep_after_org_policy_updates
  ]
}

resource "google_project_service" "enable_bigquery_google_apis" {
  project = var.project_id
  service = "bigquery.googleapis.com"
  disable_dependent_services = true
  depends_on = [
    time_sleep.sleep_after_org_policy_updates
  ]
}

resource "google_project_service" "enable_storage_google_apis" {
  project = var.project_id
  service = "storage.googleapis.com"
  disable_dependent_services = true
  depends_on = [
    time_sleep.sleep_after_org_policy_updates
  ]
}
resource "google_project_service" "enable_composer_google_apis" {
  project = var.project_id
  service = "composer.googleapis.com"
  disable_dependent_services = true
  depends_on = [
    time_sleep.sleep_after_org_policy_updates
  ]
}

/*******************************************
Introducing sleep to minimize errors from
dependencies having not completed
********************************************/
resource "time_sleep" "sleep_after_api_enabling" {
  create_duration = "120s"
  depends_on = [
    google_project_service.enable_orgpolicy_google_apis,
    google_project_service.enable_compute_google_apis,
    google_project_service.enable_container_google_apis,
    google_project_service.enable_containerregistry_google_apis,
    google_project_service.enable_dataproc_google_apis,
    google_project_service.enable_bigquery_google_apis,
    google_project_service.enable_storage_google_apis,
    google_project_service.enable_composer_google_apis
  ]
}



