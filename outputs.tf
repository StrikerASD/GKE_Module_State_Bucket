output "key_ring" {
  value = google_kms_key_ring.my_keyring.name
}

# output "my_key" {
#   value = google_kms_crypto_key.my_key.name
# }