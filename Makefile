katana:
	katana --dev --dev.no-fee --http.cors_origins "*" --block-time 2500 --invoke-max-steps 4294967295 

setup:
	@./scripts/setup.sh

deploy-mod:
	@./scripts/deploy_mod.sh $(MOD_NAME)

create-mod:
	@./scripts/create_mod.sh

register-specials:
	@./scripts/register_specials.sh $(MOD_ID)

register-rages:
	@./scripts/register_rages.sh $(MOD_ID)

deploy-slot:
	@./scripts/deploy_slot.sh $(PROFILE) $(ACTION)

# Define tasks that are not real files
.PHONY: deploy-slot deploy-sepolia katana setup torii generate-event-keys

# Catch-all rule for undefined commands
%:
	@echo "Error: Command '$(MAKECMDGOALS)' is not defined."
	@exit 1
