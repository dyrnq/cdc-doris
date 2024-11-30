#!/usr/bin/env bash


SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd -P)


remove_flag=""
DETACHED=${DETACHED:-}
while [ $# -gt 0 ]; do
    case "$1" in
        --detached|-d)
            DETACHED=1
            ;;
         --remove|-r)
            remove_flag="1";
            ;;
         --rr|-rr)
            remove_flag="2"
            ;;
        --*)
            echo "Illegal option $1"
            ;;
    esac
    shift $(( $# > 0 ? 1 : 0 ))
done


is_detached() {
    if [ -z "$DETACHED" ]; then
        return 1
    else
        return 0
    fi
}

docker network inspect canal &>/dev/null || docker network create --subnet 172.224.0.0/16 --gateway 172.224.0.1 --driver bridge canal


for i in $(seq 1 4); do
    mkdir -p ${HOME}/minio${i}/data1
    mkdir -p ${HOME}/minio${i}/data2
done

for i in $(seq 1 4); do

    docker volume create --name minio${i}_volume1 --opt type=none --opt device=${HOME}/minio${i}/data1 --opt o=bind 2>/dev/null || true
    docker volume create --name minio${i}_volume2 --opt type=none --opt device=${HOME}/minio${i}/data2 --opt o=bind 2>/dev/null || true

done


echo "https://github.com/minio/minio/tree/master/docs/orchestration/docker-compose"
if [ "$remove_flag" = "1" ]; then
    echo "will remove all containers, docker-compose down"
    docker compose down
elif [ "$remove_flag" = "2" ]; then
    echo "will remove all containers and data, docker-compose down --volumes"
    docker compose down --volumes
else

  if is_detached; then
      docker compose up -d
  else
      docker compose up
  fi

fi




