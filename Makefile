# TODO: Split in several files when it grows too big.

.PHONY: help
help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

# Your own make targets. They will be available together with existing ones.
-include Makefile.local

##@ Container
.PHONY: up down start stop restart rebuild logs

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

## Reusable "functions"

define dc-fn
	@docker-compose -f docker-compose.yml $(1)
endef
