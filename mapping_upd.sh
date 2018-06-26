#!/bin/bash
# Author: Maxim Vasilev <admin@qwertys.ru>
# Description: Script to update elasticsearch mappings

# Raise an error in case of unbound var
set -u
myname=`basename $0`

###
# Options
###

es_url_base=${ES_URL-"http://elasticsearch:9200"}
es_url_mapping="_mappings/_doc"
es_indices=(
    "stores"
    "products"
)
es_mapping_dir="kafka-elastic-sink-connector/mapping"

# Path to log file
log_path="/var/log/$myname.log"
log_applications=false

###
# Globs
###

# Error codes
E_MISC=20
E_BAD_ARGS=21

###
# Functions
###

logEvent() {
    timestamp=`date -R`
    log_msg="$@"

    echo "[$timestamp] $log_msg" >> $log_path
}

indexExist() {
    index=$1
    curl -sf "${es_url_base%%/}/${index}"
}

indexCreate() {
    index=$1
    mapping=`cat ${es_mapping_dir%%/}/${index}.json`
    index_json="{
  \"mappings\": {
    \"_doc\": $mapping
  }
}"
    curl -sf \
        -X PUT \
        -H 'Content-Type: application/json' \
        "${es_url_base%%/}/${index}" \
        -d $index_json
}

mappingUpdate() {
    index=$1
    curl -sf \
        -X PUT \
        -H 'Content-Type: application/json' \
        -d @${es_mapping_dir%%/}/${index}.json \
        "${es_url_base%%/}/${index%%/}/${$es_url_mapping%%/}"
}

###
# main()
###

# Redirect output
if [ "$log_applications" = "true" ]
then
    exec >> "$log_path"
    exec 2>> "$log_path"
fi

for index in ${es_indices[@]}
do
    indexExist $index || indexCreate $index
    mappingUpdate $index
done

exit 0
 
