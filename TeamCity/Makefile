.DEFAULT_GOAL := help
.PHONY: help run stop

help:
	@echo ''
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
	@echo ''

APP_NAME ?= "teamcity"

KEYS := build exec

define LOOPBODY
  ifneq ($$(filter $$(KEYS),$(v)),)
    RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
    $(eval $(RUN_ARGS):;@:)
  endif
endef

$(foreach v,$(firstword $(MAKECMDGOALS)),$(eval $(LOOPBODY)))

## Commands ##
start:
	@bash scripts/app-start.sh $(APP_NAME)

stop:
	@bash scripts/app-stop.sh $(APP_NAME)

exec:
	docker-compose -p $(APP_NAME) exec $(RUN_ARGS)

dump-config:
	docker-compose config
%:
@:
