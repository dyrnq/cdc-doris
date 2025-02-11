#!/usr/bin/env bash


fun_select_source(){
    docker run -it --rm --network host mysql:5.7.41 mysql --host 192.168.56.200 --user root --password=123456 -e "use app_db;select * from orders order by id;"
}

fun_select_target(){
    docker run -it --rm --network host mysql:5.7.41 mysql --host 192.168.56.200 --user root -P9030 -e "use app_db;select * from orders order by id;"
}



docker run -it --rm --network host mysql:5.7.41 mysql --host 192.168.56.200 --user root --password=123456 -e "use app_db;select * from orders;"
docker run -it --rm --network host mysql:5.7.41 mysql --host 192.168.56.200 --user root --password=123456 -e "use app_db; INSERT INTO orders VALUES (5, 66); "
docker run -it --rm --network host mysql:5.7.41 mysql --host 192.168.56.200 --user root --password=123456 -e "use app_db; INSERT INTO orders VALUES (6, 88); "


sleep 10s && fun_select_source && fun_select_target

docker run -it --rm --network host mysql:5.7.41 mysql --host 192.168.56.200 --user root --password=123456 -e "use app_db; update orders set price=58  where id =5;"
docker run -it --rm --network host mysql:5.7.41 mysql --host 192.168.56.200 --user root --password=123456 -e "use app_db; update orders set price=98  where id =6;"
docker run -it --rm --network host mysql:5.7.41 mysql --host 192.168.56.200 --user root --password=123456 -e "use app_db; update orders set price=50  where id =5;"


sleep 10s && fun_select_source && fun_select_target

