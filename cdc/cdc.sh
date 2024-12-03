#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd -P)

apt update;
apt install socat iproute2 -y;

# if ! ss -tunlp |grep 8081; then
#     socat TCP-LISTEN:8081,reuseaddr,fork TCP:jobmanager:8081 &
# fi

flink_cdc_home="/opt/flink-cdc"
pushd $flink_cdc_home || exit 1
./bin/flink-cdc.sh \
    "${SCRIPT_DIR}"/mysql-to-doris.yaml \
    --jar lib/mysql-connector-java-8.0.27.jar \
    --target remote
popd || exit 1