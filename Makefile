.PHONY: up
up: ## Up docker-compose.yml file
	docker-compose up -d --build

.PHONY: down
down: ## Down docker-compose.yml file
	docker-compose down --remove-orphans

.PHONY: reset
reset: ## Delete all volumes and all images
	docker volume rm $$(docker volume ls -q) && docker rmi $$(docker images -q) 