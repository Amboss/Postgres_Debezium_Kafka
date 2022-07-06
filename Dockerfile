# -- Build stage
# create db dir
RUN mkdir -p home/db
COPY ./db home/db
# creating connection between Postgres & debezium
#RUN curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" 127.0.0.1:8083/connectors/ --data "@debezium.json"
# tail the kafka topick

#RUN curl -i http://127.0.0.1:8083/connectors/exampledb-connector

#CMD docker run --tty --network kafka-net confluentinc/cp-kafkacat kafkacat -b kafka:9092 -C -s key=s -s value=avro -r http://schema-registry:8081 -t postgres.public.student