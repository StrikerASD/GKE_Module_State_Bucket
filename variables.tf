variable "google_kms_key_ring_name" {
  type = string
  description = "Please enter keyring name"
  default = "gke-keyring"
}

variable "google_kms_key_ring_location" {
  type = string
  description = "Location of the keyring. By default it will be europe-west3"
  default = "europe-west3"
}

variable "google_kms_key_ring_project" {
  type = string
  description = "Project ID in which keyring will reside. It will be Project ID in google console, and NOT Project number"
}

variable "google_kms_crypto_key_name" {
  type = string
  description = "The name of the key, for example gke-key"
}

variable "google_kms_crypto_key_rotation_period" {
  type = string
  description = "Rotation period in which key should be replaced"
  default = "100000s"
}

variable "google_kms_crypto_key_iam_member_role" {
  type = string
  description = "Describe IAM role for access to the keyring"
  default = "roles/cloudkms.admin"
}

variable "google_kms_crypto_key_iam_member_member" {
  type = string
  description = "Service Account which will have access to the keyring, which was already created in variables above."
}

variable "google_storage_bucket_name" {
  type = string
  description = "Name of a storage bucket, needs to be unique. Example: terraform_state_bucket-9287543"
}

variable "google_storage_bucket_location" {
  type = string
  description = "Location of storage bucket, default is europe-west3"
  default = "europe-west3"
}

variable "google_storage_bucket_versioning_enabled" {
  type = bool
  description = "Specify if versioning of the bucket shall apply"
  default = true
}

variable "google_storage_bucket_lifecycle_rule_condition_age" {
  type = number
  description = "Age for lifecycle rule. Default is 30 days"
  default = 30
}

variable "google_storage_bucket_lifecycle_rule_action_type" {
  type = string
  description = "What action to take when 30 days will go by. Default is - delete"
  default = "delete"
}