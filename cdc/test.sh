#!/usr/bin/env bash

docker run -it --rm --network host mysql:5.7.41 mysql --host 192.168.56.200 --user root -P9030 -e "use app_db;select * from orders;"
docker run -it --rm --network host mysql:5.7.41 mysql --host 192.168.56.200 --user root --password=123456 -e "use app_db;select * from orders;"
docker run -it --rm --network host mysql:5.7.41 mysql --host 192.168.56.200 --user root --password=123456 -e "use app_db; INSERT INTO orders VALUES (5, 66); "
docker run -it --rm --network host mysql:5.7.41 mysql --host 192.168.56.200 --user root --password=123456 -e "use app_db; INSERT INTO orders VALUES (6, 88); "
docker run -it --rm --network host mysql:5.7.41 mysql --host 192.168.56.200 --user root -P9030 -e "use app_db;select * from orders;"