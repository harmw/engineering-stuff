job "btc" {
  type = "service"

  group "btc-web" {
    count = 1
    network {
      port "web" {
        static = 5000
      }
    }

    service {
      name     = "btc"
      port     = "web"
      provider = "nomad"
    }

    task "btc-task" {
      driver = "docker"

      restart {
        attempts = 3
        delay    = "10s"
        interval = "10s"
        mode     = "fail"
      }

      config {
        image = "bitcoin-core:latest"
        ports = ["web"]
      }
    }
  }
}
