# Docker Apache PHP 5 Mysql

## How to begin?

1. Clone repository
2. Create image Mysql
3. Create image Phpmyadmin
4. Create image the Project that will have php in apache
5. Running Docker

```console
git clone https://github.com/gusttavoaguiarr/docker-apache-php5-mysql.git
cd docker-apache-php5-mysql
docker run --name mysql -e MYSQL_ROOT_PASSWORD=root -d mysql:latest
docker run --name phpmyadmin -d --link mysql:db -p 8080:80 phpmyadmin/phpmyadmin
docker build -t project:0.2 .
docker run -d -it -p 8888:8888 --name project -v `pwd`:/home/application/project -w /home/application/project --link mysql project:0.2
```

## How to access
 - Application: localhost:8888
 - Phpmyadmin: localhost:8080