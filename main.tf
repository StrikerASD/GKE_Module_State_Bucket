## We obtain GS service account in GCP console >> Cloud Storage >> Settings

resource "google_kms_crypto_key_iam_member" "crypto_key_encrypter_decrypter" {
  crypto_key_id = google_kms_crypto_key.my_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${var.google_service_account_account_id}"
}

resource "google_kms_key_ring" "my_keyring" {
  name     = var.google_kms_key_ring_name
  location = var.google_kms_key_ring_location
  project  = var.google_kms_key_ring_project
}

resource "google_kms_crypto_key" "my_key" {
  name            = var.google_kms_crypto_key_name
  key_ring        = google_kms_key_ring.my_keyring.id
  rotation_period = var.google_kms_crypto_key_rotation_period
}

resource "google_kms_crypto_key_iam_member" "iam_for_crypto_key" {
  crypto_key_id = google_kms_crypto_key.my_key.id
  role          = var.google_kms_crypto_key_iam_member_role
  member        = var.google_kms_crypto_key_iam_member_member
  depends_on = [
    google_kms_crypto_key.my_key
  ]
}

resource "google_storage_bucket" "terraform_state_bucket" {
  name     = var.google_storage_bucket_name
  location = var.google_storage_bucket_location
  project  = var.google_kms_key_ring_project

  uniform_bucket_level_access = true

  depends_on = [
    google_kms_crypto_key_iam_member.crypto_key_encrypter_decrypter
  ]

  versioning {
    enabled = var.google_storage_bucket_versioning_enabled
  }

  lifecycle_rule {
    condition {
      age = var.google_storage_bucket_lifecycle_rule_condition_age
    }
    action {
      type = var.google_storage_bucket_lifecycle_rule_action_type
    }
  }

  encryption {
    default_kms_key_name = google_kms_crypto_key.my_key.id
  }
}
