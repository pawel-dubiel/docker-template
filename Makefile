C_D := $(shell pwd)

#trick for making variables from .env available in Makefile ( in format $(VARIABLE_NAME) ) 
SOURCE_ENV := $(shell bash -c "set -o allexport ; source .env; set +o allexport ; env | sed 's/=/:=/' | sed 's/^/export /' > .makeenv")                         
include .makeenv 

#project name take from the current directory name
PROJECT_NAME := $(shell basename $(C_D))

# start docker containers
start:
	docker-compose up -d
 
# stop docker containers
stop:
	docker-compose stop

# status of currently running dockers
status:
	docker ps

# rebuild all containers from docker-compose.yml 
build: 
	docker-compose up -d --build

#here put code for downloading sources for the project it can be also git clone,  rsync, scp etc.. 
get_project:
	#rsync -arv --progress  --exclude-from '.ignore_rsync' user@example.com:/  $(C_D)/application/web
	git clone https://github.com/pawel-dubiel/dummy-project $(C_D)/application/web

#download db file from external server ( here you could put code 
download_database: 
	#scp user@example.com:/db.zip $(C_D)/temp/dump/; 
	#cd $(C_D) ; unzip db.zip
	#rm $(C_D)/temp/dump/db.zip

#upload previously downloaded database to container + execute all postscripts database updates
sync_db:
	docker exec -it $(PROJECT_NAME)_mariadb_1 /bin/sh  -c "/deploy/docker/mariadb/update_container_db"

#ssh login to apache container
ssh_apache:
	docker exec -it $(PROJECT_NAME)_web_1 /bin/bash

#ssh login to sql container
ssh_sql:
	docker exec -it $(PROJECT_NAME)_mariadb_1 /bin/bash

#ssh login to redis container
ssh_redis:
	docker exec -it $(PROJECT_NAME)_redis_1 /bin/bash

#Delete all the keys of all the existing databases in redis. This command never fails.
redis_flush:
	docker exec -it $(PROJECT_NAME)_redis_1 /bin/bash -c "redis-cli flushall "

inspect_web:
	docker inspect $(PROJECT_NAME)_web_1

inspect_sql:
	docker inspect $(PROJECT_NAME)_mariadb_1
