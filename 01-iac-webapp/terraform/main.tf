terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_compute_instance" "web" {
  name        = "web-server"
  platform_id = "standard-v3"
  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7g3v1q0f1q0b" # Ubuntu 22.04
    }
  }

  network_interface {
    subnet_id = "your_subnet_id"  # замените на свой: либо найти существующую или создать новую
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
