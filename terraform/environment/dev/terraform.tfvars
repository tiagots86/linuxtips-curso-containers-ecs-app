region = "us-east-1"

cluster_name = "linuxtips-cluster-ecs"

service_name = "chip"

service_port = 8080

service_cpu = 256

service_memory = 512

ssm_vpc_id = "/linuxtips-vpc/vpc/vpc_id"

ssm_listener = "/linuxtips/ecs/lb/listener"

ssm_private_subnet_1 = "/linuxtips-vpc/vpc/subnet_private_1a"

ssm_private_subnet_2 = "/linuxtips-vpc/vpc/subnet_private_1b"

ssm_private_subnet_3 = "/linuxtips-vpc/vpc/subnet_private_1c"

environment_variables = [
  {
    name  = "FOO"
    value = "BAR"
  },
  {
    name  = "PING"
    value = "PONG"
  }

]

capabilities = ["EC2"]

service_healthcheck = {
  healthy_threshold = 3
  unhealthy_threshold = 10
  timeout = 10
  interval = 60
  matcher = "200-399"
  path = "/healthcheck"
  port = 8080
}