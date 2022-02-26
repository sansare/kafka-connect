# kafka-connect
Kafka Connect with required pugins

This repo holds all third party plugins, necessary for running Storiqa backend and manages custom plugins.
All custom plugins are added as submodules.

# kc-plugins

- debezium-connector-postgres download from and place in https://debezium.io/releases/1.8/ kc-plugins folder
debezium-connector-postgres v1.9.0
- elastic sink connector download from https://www.confluent.io/hub/confluentinc/kafka-connect-elasticsearch and place `lib` jars in `elastic-sink-connector`
  confluentinc/kafka-connect-elasticsearch:11.1.8


git rm --cached kafka-elastic-sink-connector && rm -rf .git/modules/kafka-elastic-sink-connector && rm -rf kafka-elastic-sink-connector
git submodule add git@github.com:sansare/kafka-elastic-sink-connector.git kafka-elastic-sink-connector

git rm --cached debezium && rm -rf .git/modules/debezium && rm -rf debezium
git submodule add git@github.com:debezium/debezium.git debezium


curl -si -X PUT -H 'Content-Type: application/json' "http://127.0.0.1:9200/stores/_settings" -d ./kafka-elastic-sink-connector/mapping/stores-settings.json 

curl -si -X GET http://127.0.0.1:9200/stores/_all/_settings
