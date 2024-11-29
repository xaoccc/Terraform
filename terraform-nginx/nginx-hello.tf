terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
    host = "npipe:////./pipe/docker_engine"
}

resource "docker_image" "nginxdemoapp" {
    name = "nginxdemos/hello"
}

resource "docker_container" "nginxcontainer" {
    name  = "nginx"
    image = docker_image.nginxdemoapp.image_id
    ports {
        internal = 80
        external = 8000
    }
}