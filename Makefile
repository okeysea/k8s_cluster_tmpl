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

#####
# ansible
#####
AN_COMP_CMD=$(COMPOSE_CMD) ansible
AN_INVENTORY=-i inventory/k8s_cluster.sh -i inventory/executers.yml
AN_ENTRY_PB=site.yml
AN_CMD=$(AN_COMP_CMD) ansible-playbook $(AN_INVENTORY) $(AN_ENTRY_PB)

.PHONY: ansible-inventory ansible-sh ansible-syntax ansible-task ansible-dry ansible-dry-trace ansible-apply ansible-apply-trace
ansible-inventory:
	$(AN_COMP_CMD) ansible-inventory $(AN_INVENTORY) --list

ansible-sh:
	$(AN_COMP_CMD) bash

ansible-syntax:
	$(AN_CMD) --syntax-check

ansible-task:
	$(AN_CMD) --list-task

ansible-dry:
	$(AN_CMD) --check

ansible-dry-trace:
	$(AN_CMD) --check -vvvv

ansible-apply:
	$(AN_CMD)

ansible-apply-trace:
	$(AN_CMD) -vvvv

#####
# misc
#####
fixperm:
	sudo chown -R $(shell whoami):$(shell whoami) .
