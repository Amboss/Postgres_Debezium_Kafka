# Docker Postgres Debezium Kafka

---
### Skills and tools:
`Docker` `Docker-compose` `Postgres` `Debezium` `Zookeeper` `Kafka`

---
### Task: Create the Kafka topics monitoring pipeline

1. Kafka must produce topicks with changes in Postgres 
2. Consume created topics

---
## Progress of work:

1. [*Installing Docker*][1] infrastructure
2. Configure [*Dockerfile*][2] image configuration
3. Creating [*SQL initiation script*][3] to create and initiate test table
4. Configure [*Docker-compose*][4] services:
 * postgreSQL 13
 * zookeeper
 * kafka
 * debezium
5. Creating [*schema-registry configuration*][5] for `Debezium connect`
6. Initiating *`Docker-compose.yaml`*:

```shell
$ docker-compose up -d
```
7. Initiating connection between Postgres & debezium

```shell
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" 127.0.0.1:8083/connectors/ --data "@debezium.json"
```
8. Test created connection:

```shell
curl -i http://127.0.0.1:8083/connectors/exampledb-connector
```

9. Initiate the kafka topics monitoring

```shell
docker run --tty --network kafka-net confluentinc/cp-kafkacat kafkacat -b kafka:9092 -C -s key=s -s value=avro -r http://schema-registry:8081 -t postgres.public.student
```
10. Add SQl data to monitor changes in kafka topics:
 * open additional terminal window
 * open docker container list:

```shell
$ docker ps
```

 * enter to container with PostgreSQL:


```shell
$ docker exec -it postgres_container_id /bin/sh
```

 * open PSQL session to exempledb database

```shell
$ psql -U docker -d exampledb -W
```

 * insert new data to *student* table:

```shell
$ INSERT INTO student VALUES (04, 'Ironman');
```
 * Kafka will produce new topic with values (04, 'Ironman') in host terminal

 * update data in *student* table:

```shell
$ UPDATE student SET name='Hulk' WHERE id=04;
```
 * Kafka will produce new topic with values (04, 'Hulk') in host terminal


[1]:https://docs.docker.com/engine/install/ubuntu/
[2]:https://github.com/Amboss/Postgres_Debezium_Kafka/blob/master/Dockerfile
[3]:https://github.com/Amboss/Postgres_Debezium_Kafka/blob/master/db/init.sql
[4]:https://github.com/Amboss/Postgres_Debezium_Kafka/blob/master/docker-compose.yaml
[5]:https://github.com/Amboss/Postgres_Debezium_Kafka/blob/master/debezium.json
