backend "consul" {
  address = "127.0.0.1:8500"
  path = "vault"
  advertise_addr = "127.0.0.1"
}

listener "tcp" {
  address = "127.0.0.1:8200"
  tls_disable = 1
}
