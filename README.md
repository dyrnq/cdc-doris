# cdc-doris

a poc for cdc to doris, and simplified version [cdc-vagrant](https://github.com/dyrnq/cdc-vagrant).

it has the following components:
- minio
- flink cluster
- zookeeper
- doris
- mysql

## quick start

```bash
vagrant up cdc

```

| service      | url                         |
|--------------|-----------------------------|
| doris web    | http://192.168.56.200:8030  |
| zoonavigator | http://192.168.56.200:39000 |
| minio web    | http://192.168.56.200:9000  |
| flink web    | http://192.168.56.200:48081 |
| adminer web  | http://192.168.56.200:48080 |


## flink-cluster

Run a small flink-standalone cluster with zookeeper and minio.

```bash
vagrant ssh cdc

cd /vagrant/misc
./launch.sh

cd /vagrant/minio
./launch.sh

sleep 10;

./init.sh

cd /vagrant/flink
./launch.sh
```

## doris

```bash
vagrant ssh cdc
cd /vagrant/doris
./launch.sh

sleep 10;

./init.sh
```


## flink-cdc

```bash
vagrant ssh cdc
cd /vagrant/cdc
./launch.sh

sleep 10;

docker compose exec -it cdc bash

root@cdc:/opt/flink# /data/install-flink-cdc.sh

root@cdc:/opt/flink# /data/cdc.sh
```

```bash
## architecture
                                minio (s3 cluster)
                                        ^
                                        |
                                        |
souce                                                       sink
mysql                ----> flink standalone cluster ---->   apache doris
192.168.56.200:3306                     |                   192.168.56.200:8030
                                        |
                                        v
                                zookeeper cluster
```