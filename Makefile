setup:
	@./scripts/setup.sh ${1}

deploy-mod:
	@./scripts/deploy_mod.sh ${1} ${2}

# Define tasks that are not real files
.PHONY: setup deploy-mod

# Catch-all rule for undefined commands
%:
	@echo "Error: Command '$(MAKECMDGOALS)' is not defined."
	@exit 1
