# TODO: Split in several files when it grows too big.
PROJECT_NAME:=$(notdir $(patsubst %/,%,$(CURDIR)))
DB_VOLUME_NAME:=db_app
DB_VOLUME:=${PROJECT_NAME}_${DB_VOLUME_NAME}
NOW:=$(strip $(shell date "+%Y%m%d%H%M%S"))

.PHONY: help
help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

# Your own make targets. They will be available together with existing ones.
-include Makefile.local

##@ Container
.PHONY: up down start stop restart rebuild logs status

up: ## Up the docker containers
	$(call dc-fn,up -d)
down: ## Down the docker containers
	$(call dc-fn,down --remove-orphans)
start: ## Start the docker containers
	$(call dc-fn,start)
stop: ## Stop the docker containers
	$(call dc-fn,stop)
restart: ## Restart the docker containers
	$(call dc-fn,restart)
rebuild: down ## Rebuild and start the docker containers
	$(call dc-fn,up --build --force-recreate -d)
logs: ## Show the most recent docker log entries
	$(call dc-fn,logs --follow --tail=100)
status: ## Show the status of running containers
	$(call dc-fn,ps)

##@ Backup
.PHONY: backup-db restore-db

backup-db: stop ## Backup database volume and save in the backup folder
	$(call ubuntu-fn,tar -zcf /backup/${DB_VOLUME}_${NOW}.tgz /data)
restore-db: ## Restore a backup from DATE to the database volume
	$(call ubuntu-fn,bash -c "rm -rf /data/* && tar -zxf /backup/${DB_VOLUME}_${DATE}.tgz -C /data --strip 1")

##@ Helpers
.PHONY: generate-secret

generate-secret: ## Generate a random secret
	 @LC_ALL=C </dev/urandom tr -dc 'A-Za-z0-9!"#$%&()*+,-./:;<=>?@[\]^_`\{|\}~' | head -c 32 ; echo

## Reusable "functions"

define dc-fn
	@docker-compose -f docker-compose.yml $(1)
endef

define ubuntu-fn
	@docker run --rm -v ${DB_VOLUME}:/data -v $(CURDIR)/backup:/backup ubuntu $(1)
endef
