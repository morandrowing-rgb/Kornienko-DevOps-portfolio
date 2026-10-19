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
  zone           = var.zone
  network_id     = yandex_vpc_network.bookstore-net.id
  v4_cidr_blocks = [var.subnet_cidr]
}

# 3. Создаем виртуальную машину
resource "yandex_compute_instance" "bookstore-vm" {
  name        = "bookstore-app-server"
  platform_id = "standard-v3" # Самый актуальный тип прерываемых машин
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_image_id
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.bookstore-subnet.id # подсеть создана выше этим конфигом, заглушка не нужна
    nat       = true # Включаем публичный IP
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }
}

# Выводим IP адрес после создания
output "external_ip" {
  value = yandex_compute_instance.bookstore-vm.network_interface.0.nat_ip_address
}
