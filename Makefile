# Terraform Version for spinning up the infrastucture

TerraformVersion = "0.13.2"
jqVersion        = "1.5"

# Installing terraform and jq in the linux agent

install_terraform_linux:

	wget https://releases.hashicorp.com/terraform/$(TerraformVersion)/terraform_$(TerraformVersion)_linux_amd64.zip

	unzip terraform_$(TerraformVersion)_linux_amd64.zip

	
install_JQ_linux:

	wget https://github.com/stedolan/jq/releases/download/jq-$(jqVersion)/jq-linux64
	
	mv jq-linux64 jq
	
	chmod +x jq

# Validating the terraform

terraform_validate:

	./terraform init -backend-config='tf.backend.$(ENVIRONMENT).tfvars'

	./terraform validate -var-file=tf.$(ENVIRONMENT).tfvars 


# Creating terraform plan

terraform_plan:

	./terraform plan -var-file=tf.$(ENVIRONMENT).tfvars -out="tf.$(ENVIRONMENT).tfplan" -var "azure-subscription-id=$(ARM_SUBSCRIPTION_ID)" -var "azure-client-id=$(ARM_CLIENT_ID)" -var "azure-client-secret=$(ARM_CLIENT_SECRET)" -var "azure-tenant-id=$(ARM_TENANT_ID)"
	

# Applying the created terraform plan

terraform_apply:

	./terraform apply -auto-approve "tf.$(ENVIRONMENT).tfplan"

# Destroying infrastructure using the terraform plan	

terraform_output:

	./terraform output -json > $(APPID)_$(ENVIRONMENT).json

	cat $(APPID)_$(ENVIRONMENT).json | jq "del (.[] .type, .[] .sensitive) | {client_id: .client_id[], tenant_id: .tenant_id[],secret: .secret[]} " > $(APPID)_$(ENVIRONMENT)_spn.json
	
	# cat $(APPID)_$(ENVIRONMENT).json | jq "del (.[] .type, .[] .sensitive)" > $(APPID)_$(ENVIRONMENT)_spn.json

	
terraform_destroy:

	./terraform destroy -force -var-file=tf.$(ENVIRONMENT).tfvars


# Cleaning obselete files from the agent

terraform_clean:

	rm -rf .terraform

	rm -rf "terraform"

	rm -rf ".git"

	rm -rf ".gitignore"

	rm -rf "terraform_$(TerraformVersion)_linux_amd64.zip"
	
	rm -rf "jq-linux64"
