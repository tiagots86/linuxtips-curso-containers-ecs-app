# linuxtips-curso-containers-ecs-app
Repositório para aplicação ECS utilizando módulo

## Comandos úteis

```
docker pull fidelissauro/chip:v2

docker tag fidelissauro/chip:v2 <AWS ID>.dkr.ecr.us-east-1.amazonaws.com/linuxtips-cluster-ecs/chip:latest

docker push <AWS ID>.dkr.ecr.us-east-1.amazonaws.com/linuxtips-cluster-ecs/chip:latest

curl <Load balancer DNS>/system -H "Host: chip.linuxtips.demo"
```