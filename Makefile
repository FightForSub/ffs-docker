
DATA_DIR = data

_volumes: ## create volumes directories
	mkdir -p -v \
		$(DATA_DIR)/maven-repo \
		src/
.PHONY: _volumes

_repos: _volumes ## init git repos
	git clone https://github.com/AlexMog/ApiLib.git -b master ./src/ApiLib
	git clone https://github.com/FightForSub/FFS-Api.git -b develop ./src/FFS-Api
	git clone https://github.com/FightForSub/FFS-PubSub.git -b develop ./src/FFS-PubSub
	git clone https://github.com/FightForSub/ffs-zera.git -b development ./src/ffs-zera
.PHONY: _repos

init:_volumes _repos
.PHONY: init


vendor: ## install vendors
	docker-compose run --rm app-ffs sh -c "npm ci && chmod -R 777 /ffs-zera/node_modules/"
	docker-compose run --rm api sh -c "cd /ApiLib/ && mvn clean install -U && chmod -R 777 /root/.m2"
	docker-compose run --rm api sh -c "cd /FFS-Api/ && mvn dependency:resolve -U && chmod -R 777 /root/.m2"
	docker-compose run --rm api sh -c "cd /FFS-PubSub/ && mvn dependency:resolve -U && chmod -R 777 /root/.m2"
.PHONY: vendor

up: ## launch all services
	docker-compose up
.PHONY: up

destroy:
	sudo rm -rf $(DATA_DIR)
	sudo rm -rf src/
.PHONY: destroy
