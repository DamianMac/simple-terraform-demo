module "basic-infrastructure" {
    source = "./modules/simple"
    ami = "ami-023eb5c021738c6d0"
    instance_size = "t2.micro"
    environment_name = "Production"
}