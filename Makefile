COMPOSE_CMD=docker-compose run --rm

#####
# terraform
#####

TF_COMP_CMD=$(COMPOSE_CMD) terraform
TF_VARF=vars.tfvars
TF_CMD=$(TF_COMP_CMD)

.PHONY: terraform-init terraform-fmt terraform-plan terraform-apply terraform-destroy

terraform-init:
	$(TF_CMD) init

terraform-fmt:
	$(TF_CMD) fmt

terraform-plan:
	$(TF_CMD) plan -var-file=$(TF_VARF)

terraform-apply:
	$(TF_CMD) apply -var-file=$(TF_VARF)

terraform-destroy:
	$(TF_CMD) destroy -var-file=$(TF_VARF)
