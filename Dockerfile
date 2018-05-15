FROM confluentinc/cp-kafka-connect:4.0.0

ENV CONNECT_PLUGIN_PATH="/etc/kafka-connect/plugins"

RUN mkdir -p /etc/kafka-connect/plugins
COPY kc-plugins /etc/kafka-connect/plugins
COPY kafka-elastic-sink-connector/target/kafka-elastic-sink-connector-1.0-SNAPSHOT.jar \
  /etc/kafka-connect/plugins/elastic-sink-connector/
COPY debezium/debezium-core/target/debezium-core-0.8.0-SNAPSHOT.jar \
  /etc/kafka-connect/plugins/debezium-connector-postgres/
COPY debezium/debezium-connector-postgres/target/debezium-connector-postgres-0.8.0-SNAPSHOT.jar
  /etc/kafka-connect/plugins/debezium-connector-postgres/
