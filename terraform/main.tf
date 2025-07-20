

#Dev-infra
module "dev-infra" {
  source = "./infra"
  env = "dev"
  ins-count = 1
  ami = "ami-0f918f7e67a3323f0" #May differ in other regions
  instance_type = "t2.micro"
  ebs-v-size = 10
  ebs-v-type = "gp3"
}

#stg-infra
module "stg-infra" {
  source = "./infra"
  env = "stg"
  ins-count = 2
  ami = "ami-0f918f7e67a3323f0"  #May differ in other regions
  instance_type = "t2.micro"
  ebs-v-size = 10
  ebs-v-type = "gp3"
}

#prod-infra
module "prod-infra" {
  source = "./infra"
  env = "prod"
  ins-count = 2
  ami = "ami-0f918f7e67a3323f0"  #May differ in other regions
  instance_type = "t2.small"
  ebs-v-size = 15
  ebs-v-type = "gp3"
}


output "dev-ips" {
  value = module.dev-infra.ec2_public_ips
}

output "stg-ips" {
  value = module.stg-infra.ec2_public_ips
}

output "prod-ips" {
  value = module.prod-infra.ec2_public_ips
}

terraform { #Enabling remote backend for state file
  backend "s3" {
    bucket = "backend-bucket-for-state-file"
    key = "global/s3/terraform.tfstate"
    region = "ap-south-1"

    dynamodb_table = "DynamoDb-for-state-locking"
    encrypt = true

  }
}