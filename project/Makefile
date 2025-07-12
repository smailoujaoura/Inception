all:
	mkdir -p /home/soujaour/data/db /home/soujaour/data/wp
	docker compose -f srcs/docker-compose.yml up --build -d

down:
	docker compose -f srcs/docker-compose.yml down

clean:
	echo "should clean just containers for example"

fclean: down
	docker system prune -af
	sudo rm -rf /home/soujaour/data/db
	sudo rm -rf /home/soujaour/data/wp

nuke: fclean
	docker volume rm srcs_mariadb
	docker volume rm srcs_wordpress

re: nuke all

redo:
	docker compose -f srcs/docker-compose.yml down
	docker compose -f srcs/docker-compose.yml up --build