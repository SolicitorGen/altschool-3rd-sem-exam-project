# resource "google_service_account" "gke_sa" {
#   account_id   = "service-account-id"
#   display_name = "GKE service account"
# }

# data "google_iam_policy" "gke_node_manager" {
#   binding {
#     role = "roles/iam.serviceAccountUser"

#     members = [
#       "serviceAccount:${google_service_account.gke_sa.email}",
#     ]
#   }
# }

# resource "google_service_account_iam_policy" "admin-account-iam" {
#   service_account_id = google_service_account.gke_sa.name
#   policy_data        = data.google_iam_policy.gke_node_manager.policy_data
# }
