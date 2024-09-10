# linuxtips-curso-containers-ecs-app
Repositório para aplicação ECS utilizando módulo

## Comandos úteis

```
docker pull fidelissauro/chip:v2

docker tag fidelissauro/chip:v2 481768428259.dkr.ecr.us-east-1.amazonaws.com/linuxtips-cluster-ecs/chip:latest

docker push 481768428259.dkr.ecr.us-east-1.amazonaws.com/linuxtips-cluster-ecs/chip:latest

curl <Load balancer DNS>/system -H "Host: chip.linuxtips.demo"
```