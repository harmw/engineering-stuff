job "nginx" {
  datacenters = ["dc1"]
  type = "service"

  group "web" {
    # Just launch some instances at the start, we can scale from there
    count = 5

    network {
      port "http" {
        static = 8080
      }
    }

    # This requires Consul, which we don't currently have
    #service {
    #  port = "http"
    #  check {
    #    type = "http"
    #    path = "/"
    #    interval = "10s"
    #    timeout = "2s"
    #  }
    #}

    task "frontend" {
      driver = "docker"

      config {
        image = "nginx:latest"
        ports = ["http"]
      }

      resources {
        cpu    = 100 # MHz
        memory = 128 # MB
      }
    }
  }
}
