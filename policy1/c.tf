provider "google"{
    credentials = file(var.gcp_key)
    project = var.gcp_project_id
    region = var.gcp_region
}

resource "google_secure_source_manager_instance" "instance" {
    location = var.gcp_region
    instance_id = "my-instance"
}

resource "google_secure_source_manager_repository" "repository" {
    location = var.gcp_region
    repository_id = "my-repository"
    instance = google_secure_source_manager_instance.instance.name
}

resource "google_secure_source_manager_branch_rule" "basic" {
    branch_rule_id = "my-basic-branchrule"
    repository_id = google_secure_source_manager_repository.repository.repository_id
    location = google_secure_source_manager_repository.repository.location
    include_pattern = "main"
    require_pull_request = true
    minimum_approvals_count   = 2
}