#!/usr/bin/env bash

docker run -i --rm --network host --entrypoint '' minio/mc bash<<EOF
mc alias set myminio http://192.168.56.200:9000 minioadmin minioadmin;
mc admin user svcacct add --access-key "u5SybesIDVX9b6Pk" --secret-key "lOpH1v7kdM6H8NkPu1H2R6gLc9jcsmWM" myminio minioadmin 2>/dev/null || true;
EOF

docker run -i --rm --network host --entrypoint '' minio/mc bash<<EOF
mc alias set myminio http://192.168.56.200:9000 minioadmin minioadmin;

mc mb myminio/flink
mc mb myminio/flink-state

EOF