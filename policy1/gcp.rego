package terraform.analysis

authz if some_main_branch_rule_is_secure

some_main_branch_rule_is_secure if {
  some res_key
  res := input.resource_changes[res_key]

  res.type == "google_secure_source_manager_branch_rule"
  after := res.change.after

  after.include_pattern == "main"
  after.require_pull_request
  after.minimum_approvals_count > 1
}

deny[reason] if{
 some res_key
  res := input.resource_changes[res_key]
  res.type == "google_secure_source_manager_instance_iam_member"
  res.change.after.role == "roles/securesourcemanager.instanceOwner"
  reason := sprintf("Direct assignment of 'instanceOwner' to user '%s' is not allowed.", [res.change.after.member])
}
