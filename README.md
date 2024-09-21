# linuxtips-curso-containers-ecs-app
Repositório para aplicação ECS utilizando módulo

## Comandos úteis

```
docker pull fidelissauro/chip:v2

docker tag fidelissauro/chip:v2 <AWS ID>.dkr.ecr.us-east-1.amazonaws.com/linuxtips-cluster-ecs/chip:latest

docker push <AWS ID>.dkr.ecr.us-east-1.amazonaws.com/linuxtips-cluster-ecs/chip:latest

curl <Load balancer DNS>/system -H "Host: chip.linuxtips.demo"
```

## Capacity Provider

base
The base value designates how many tasks, at a minimum, to run on the specified capacity provider. Only one capacity provider in a capacity provider strategy can have a base defined. If no value is specified, the default value of 0 is used.

Type: Integer

Valid Range: Minimum value of 0. Maximum value of 100000.

Required: No

weight
The weight value designates the relative percentage of the total number of tasks launched that should use the specified capacity provider. The weight value is taken into consideration after the base value, if defined, is satisfied.

If no weight value is specified, the default value of 0 is used. When multiple capacity providers are specified within a capacity provider strategy, at least one of the capacity providers must have a weight value greater than zero and any capacity providers with a weight of 0 can't be used to place tasks. If you specify multiple capacity providers in a strategy that all have a weight of 0, any RunTask or CreateService actions using the capacity provider strategy will fail.

An example scenario for using weights is defining a strategy that contains two capacity providers and both have a weight of 1, then when the base is satisfied, the tasks will be split evenly across the two capacity providers. Using that same logic, if you specify a weight of 1 for capacityProviderA and a weight of 4 for capacityProviderB, then for every one task that's run using capacityProviderA, four tasks would use capacityProviderB.

Type: Integer

Valid Range: Minimum value of 0. Maximum value of 1000.

Required: No
