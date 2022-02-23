# kafka-connect
Kafka Connect with required pugins

This repo holds all third party plugins, necessary for running Storiqa backend and manages custom plugins.
All custom plugins are added as submodules.




git rm --cached kafka-elastic-sink-connector && rm -rf .git/modules/kafka-elastic-sink-connector && rm -rf kafka-elastic-sink-connector
git submodule add git@github.com:sansare/kafka-elastic-sink-connector.git kafka-elastic-sink-connector

git rm --cached debezium && rm -rf .git/modules/debezium && rm -rf debezium
git submodule add git@github.com:sansare/debezium.git debezium
