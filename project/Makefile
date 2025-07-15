all:
	mkdir -p /home/soujaour/data/db
	mkdir -p /home/soujaour/data/wp
	mkdir -p /home/soujaour/data/uptimer
	mkdir -p /home/soujaour/data/portainer
	docker compose -f srcs/docker-compose.yml up --build -d

down:
	docker compose -f srcs/docker-compose.yml down

fclean: down
	docker system prune -af
	sudo rm -rf /home/soujaour/data/db
	sudo rm -rf /home/soujaour/data/wp
	sudo rm -rf /home/soujaour/data/uptimer
	sudo rm -rf /home/soujaour/data/portainer

nuke: fclean
	docker volume rm srcs_mariadb
	docker volume rm srcs_wordpress
	docker volume rm srcs_uptimer
	docker volume rm srcs_portainer

re: nuke all

redo:
	docker compose -f srcs/docker-compose.yml down
	docker compose -f srcs/docker-compose.yml up -d --build