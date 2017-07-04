FROM ubuntu:14.04

# AUTHOR
MAINTAINER Gustavo Aguiar <gusttavoaguiarr@gmail.com>

VOLUME `pwd` /home/application/project
WORKDIR /home/application/project

# UPDATE
RUN apt-get update

# UTILS
RUN apt-get -y install vim wget dialog net-tools curl
RUN apt-get -y install python-pip
RUN pip install supervisor --pre

ADD server-confs/supervisord.conf /etc/supervisord.conf

# PHP
RUN apt-get -y install php5 libapache2-mod-php5 php5-mcrypt php5-mysql php5-cli php5-curl
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# APACHE
RUN apt-get -y install apache2
ADD server-confs/ports.conf /etc/apache2/ports.conf
ADD server-confs/apache2.conf /etc/apache2/apache2.conf
ADD server-confs/000-default.conf /etc/apache2/sites-available/000-default.conf

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php5/apache2/php.ini


# START APP
CMD make start


EXPOSE 8888


### BUILD
#docker build -t project:0.2 .
#docker run --name mysql -e MYSQL_ROOT_PASSWORD=root -d mysql:latest


### START CONTAINER
#docker run -d -it -p 8888:8888 --name project -v `pwd`:/home/application/project -w /home/application/project --link mysql project:0.2

# REMOVE containers none
# docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")

### Realizando importação dos dados
#docker exec -i mysql mysql -uroot -p123 db < mysql.sql
