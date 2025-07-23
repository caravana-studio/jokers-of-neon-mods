setup:
	@./scripts/setup.sh $(PROFILE)

deploy-mod:
	@./scripts/deploy_mod.sh $(PROFILE) $(MOD_NAME)

# Define tasks that are not real files
.PHONY: setup deploy-mod

# Catch-all rule for undefined commands
%:
	@echo "Error: Command '$(MAKECMDGOALS)' is not defined."
	@exit 1
