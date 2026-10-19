variable "subnet_id" {
  description = "ID существующей подсети Yandex Cloud для VM. Узнать: yc vpc subnet list. Свой ID сюда подставляет владелец стенда, в репозитории хранится только пример."
  type        = string
}
