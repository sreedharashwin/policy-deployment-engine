resource "google_secure_source_manager_instance_iam_member" "member" {
  project = google_secure_source_manager_instance.instance.project
  location = google_secure_source_manager_instance.instance.location
  instance_id = google_secure_source_manager_instance.instance.instance_id
  role = "roles/securesourcemanager.instanceOwner"
  member = "user:jane@example.com"
}