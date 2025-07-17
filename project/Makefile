all:
	mkdir -p /home/soujaour/data/db
	mkdir -p /home/soujaour/data/wp
	mkdir -p /home/soujaour/data/uptimer
	docker compose -f srcs/docker-compose.yml up --build -d

up:
	docker compose -f srcs/docker-compose.yml up --build -d

stop:
	docker compose -f srcs/docker-compose.yml stop

down:
	docker compose -f srcs/docker-compose.yml down

restart:
	docker compose -f srcs/docker-compose.yml restart

re: down
	docker compose -f srcs/docker-compose.yml up -d --build

clean:
	docker compose -f srcs/docker-compose.yml down --rmi all --volumes

fclean: clean
	docker system prune -af
	sudo rm -rf /home/soujaour/data

redo: fclean all
