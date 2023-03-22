variable "project_id" {
  description = "project id"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "region" {
  description = "region"
  type        = string
}

variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
  type        = number
}

variable "credentials_file" {
  default     = "serviceaccount.json"
  description = "number of gke nodes"
  type        = string
}
