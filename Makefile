supervisor:
		supervisord -c /etc/supervisord.conf

start: supervisor
		tail -f /var/log/apache2/access.log

docker-build:
	docker build -t project:0.2 .

docker-create:
	docker run -d -it -p 8888:8888 --name project -v `pwd`:/home/application/project -w /home/application/project --link phppgadmindocker_db_1 project:0.2

docker-logs:
	docker logs -f project
