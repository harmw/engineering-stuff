.PHONY: validate
validate:
	terraform -chdir=terraform init -backend=false
	terraform -chdir=terraform validate
	terraform fmt -check -diff terraform/
	tflint --init
	tflint --chdir=terraform/

.PHONY: test
test: validate

.PHONY: plan
plan:
	terraform -chdir=terraform/ plan -no-color -out tf.plan -refresh=false
	terraform -chdir=terraform/ show -json tf.plan > tf.plan.json

.PHONY: apply
apply:
	echo not implemented

