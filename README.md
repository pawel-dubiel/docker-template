Description
============

A very simple and basic template for my typical LAMP project with multiple docker containers.

currently supported are: apache/php MariaDB Redis

todo: add mail container, add support for Cronjobs

Requirements
=============

### tested with:
Docker version 1.11.1, build 5604cbe

docker-compose version 1.7.1, build 6c29830

install docker compose at least 1.11

### install docker
  follow instructions on docker website

### install docker compose
  follow instructions on docker website however it should be something like below

curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose


 Directory structure
====================

- deploy ( files related to containers  )
- state  ( for storing state like databases, session etc, this is not a place for Dockerfiles )
- temp   ( for storing temporary files ( database dumps etc )
- logs   ( for storing logs ( apache, mysql ) )

Basic Usage
===========

  - apache config files are at:  
   - deploy/php-apache/config/http_host.conf
   - deploy/php-apache/config/ssl_host.conf
      - to add ssl host edit deploy/php-apache/Dockerfile ( and uncomment COPY config/ssl_host.conf /etc/apache2/sites-enabled/ )


 - make build  
   - Build all containers specified in docker-compose.yml


 - make redis_flush
   - Delete all the keys of all the existing databases in Redis.


 - make ssh_apache
  - SSH into PHP/HTTP container


 - make ssh_sql
	- SSH into MariaDB container


 - make ssh_redis
	- SSH into Redis container


 - review Makefile for other functions ( these function need to be extended with your own code like make sync_db, make get_project, make download_database )

 - to change PHP version edit deploy/php-apache/Dockerfile ( FROM php:5.5.37-apache )
