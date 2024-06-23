FROM confluentinc/cp-kafka-connect:7.6.1

ENV CONNECT_PLUGIN_PATH="/etc/kafka-connect/plugins"

RUN mkdir -p /etc/kafka-connect/plugins ./kafka-elastic-sink-connector/mapping/
COPY kc-plugins /etc/kafka-connect/plugins
COPY kafka-elastic-sink-connector/target/kafka-elastic-sink-connector-1.0-SNAPSHOT.jar /etc/kafka-connect/plugins/elastic-sink-connector/
#COPY debezium/debezium-core/target/debezium-core-1.9.0-SNAPSHOT.jar /etc/kafka-connect/plugins/debezium-connector-postgres/
#COPY debezium/debezium-connector-postgres/target/debezium-connector-postgres-1.9.0-SNAPSHOT.jar /etc/kafka-connect/plugins/debezium-connector-postgres/
COPY kafka-elastic-sink-connector/mapping/ ./kafka-elastic-sink-connector/mapping/
COPY mapping_upd.sh /mapping_upd.sh

ENTRYPOINT bash -x /mapping_upd.sh && /etc/confluent/docker/run
