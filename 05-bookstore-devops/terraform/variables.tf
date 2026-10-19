variable "zone" {
  description = "Зона Yandex Cloud, в которой создаются подсеть и VM"
  type        = string
  default     = "ru-central1-a"
}

variable "subnet_cidr" {
  description = "CIDR подсети bookstore-subnet. Подсеть создаётся этим же конфигом, поэтому subnet_id НЕ задаётся вручную: VM берёт yandex_vpc_subnet.bookstore-subnet.id"
  type        = string
  default     = "192.168.10.0/24"
}

variable "vm_image_id" {
  description = "ID образа загрузочного диска (по умолчанию Ubuntu 22.04 LTS). Проверяйте актуальность: yc compute image list --folder-id standard-images"
  type        = string
  default     = "fd80lemtn8vjdm0pjc3i"
}

variable "ssh_public_key_path" {
  description = "Путь к публичному SSH-ключу для пользователя ubuntu"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
