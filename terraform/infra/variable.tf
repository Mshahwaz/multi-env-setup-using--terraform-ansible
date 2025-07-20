variable "env" {
  type = string
  description = "Environment required e.g dev,stg,prod "
}


variable "ami" {
    type = string
    description = "Amazon machine image e.g ubuntu, Red-hat etc."
}

variable "ins-count" {
  type = number
  description = "No of instance required"
}

variable "instance_type" {
  type = string
  description = "Amazon machine image type e.g t2.micro, t2.medium "
}

variable "ebs-v-type" {
  type = string
  description = " EBS Volumne Type"
}

variable "ebs-v-size" {
  type = number
  description = "EBS Voulume size "
}