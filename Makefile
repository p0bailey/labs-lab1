COMMAND = terraform
DIR = tfvars
FILES = $(wildcard $(DIR)/*.tfvars)
TF_GLOBAL_FILE = ../terraform.tfvars

.PHONY: all

all:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: ## Terraform init
	$(COMMAND) init
	

plan:  $(FILES) ## Terraform plan
	@for file in $^; do \
		$(COMMAND) plan -var-file=$(TF_GLOBAL_FILE) -var-file=$$file  -state=$$file.tfstate; \
	done

apply:  $(FILES) ## Terraform apply
	@for file in $^; do \
		$(COMMAND) apply -var-file=$(TF_GLOBAL_FILE) -auto-approve -var-file=$$file -state=$$file.tfstate; \
	done

destroy:  $(FILES) ## Terraform destroy !!!BE CAREFULL!!!!
	@for file in $^; do \
		$(COMMAND) destroy -var-file=$(TF_GLOBAL_FILE) -auto-approve -var-file=$$file -state=$$file.tfstate; \
	done

clean:  ## This step will clean the environment from tfstate .tfstate.backup .terraform
	rm -f $(DIR)/*.tfstate
	rm -f $(DIR)/*.tfstate.backup
	rm -rf .terraform
