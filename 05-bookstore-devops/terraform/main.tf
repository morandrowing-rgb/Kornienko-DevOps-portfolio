terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  # Переменные будут браться из окружения (YC_TOKEN, YC_CLOUD_ID, YC_FOLDER_ID)
}

# 1. Создаем сеть
resource "yandex_vpc_network" "bookstore-net" {
  name = "bookstore-network"
}

# 2. Создаем подсеть в зоне a
resource "yandex_vpc_subnet" "bookstore-subnet" {
  name           = "bookstore-subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.bookstore-net.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# 3. Создаем виртуальную машину
resource "yandex_compute_instance" "bookstore-vm" {
  name        = "bookstore-app-server"
  platform_id = "standard-v3" # Самый актуальный тип прерываемых машин
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80lemtn8vjdm0pjc3i" # Ubuntu 22.04 LTS
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.bookstore-subnet.id
    nat       = true # Включаем публичный IP
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

# Выводим IP адрес после создания
output "external_ip" {
  value = yandex_compute_instance.bookstore-vm.network_interface.0.nat_ip_address
}
