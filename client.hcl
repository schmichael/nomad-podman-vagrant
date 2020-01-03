log_level = "TRACE"
enable_debug = true

datacenter = "dc1"

data_dir = "/vagrant/data"
plugin_dir = "/vagrant/plugins"

name = "nomad-devagent"

bind_addr = "0.0.0.0"

advertise {
  http = "127.0.0.1"
  serf = "127.0.0.1"
  rpc  = "127.0.0.1"
}

client {
  enabled = true

  servers = ["127.0.0.1:4647"]

  options = {
    "driver.raw_exec.enable" = "1"
    "docker.image.delay" = "10s"
  }
}

server {
  enabled          = true
  bootstrap_expect = 1
  num_schedulers   = 1
}

plugin "nomad-driver-podman" { }
