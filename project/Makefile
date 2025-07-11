all:
	mkdir -p /home/soujaour/data/db /home/soujaour/data/wp
	docker compose -f srcs/docker-compose.yml up --build -d

down:
	docker compose -f srcs/docker-compose.yml down

fclean: down
	docker system prune -af
	sudo rm -rf /home/soujaour/data/db
	sudo rm -rf /home/soujaour/data/wp

re: fclean all