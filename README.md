### Prerequisites

Make

Docker https://docs.docker.com/install/

Docker compose https://docs.docker.com/compose/install/

### Setup env (clone repositories, create folder)

```
make setup
```

### Install dependencies (node_modules, mvn dependencies, ...)

```
make vendor
```

### Launch all containers

```
make up
```

Front => app-ffs.localhost
RabbitMQ => broker.localhost
Api => api-ffs.localhost

### Remove repos and data

```
make destroy
```
