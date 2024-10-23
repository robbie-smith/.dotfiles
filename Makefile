# Variables
AWS_DEV_ACCOUNT := 148761656253
AWS_DEV_REGION := us-west-2

.PHONY: deploy
build:
	@echo "Running brazil-build..."
	AWS_DEV_ACCOUNT=$(AWS_DEV_ACCOUNT) AWS_DEV_REGION=$(AWS_DEV_REGION) brazil-build

deploy:
	@echo "Fetching list of CDK stacks..."
	@AWS_DEV_ACCOUNT=$(AWS_DEV_ACCOUNT) AWS_DEV_REGION=$(AWS_DEV_REGION) brazil-build cdk list | { \
		CDK_LIST_OUTPUT=$$(cat); \
		echo "CDK List Output:"; \
		echo "$$CDK_LIST_OUTPUT"; \
		\
		echo "Fetching Bootstrap stack..."; \
		DEV_BOOTSTRAP_STACK=$$(echo "$$CDK_LIST_OUTPUT" | grep -o "BONESBootstrap-[^ ]*-dev-[0-9]\+-$(AWS_DEV_REGION)" | head -n 1); \
		if [ -z "$$DEV_BOOTSTRAP_STACK" ]; then \
			echo "Error: No dev bootstrap stack found. Please check the output of cdk list."; \
			exit 1; \
		fi; \
		echo "Bootstrapping with stack: $$DEV_BOOTSTRAP_STACK"; \
		AWS_DEV_ACCOUNT=$(AWS_DEV_ACCOUNT) AWS_DEV_REGION=$(AWS_DEV_REGION) brazil-build bootstrap $$DEV_BOOTSTRAP_STACK; \
		\
		echo "Fetching Service stack..."; \
		DEV_SERVICE_STACK=$$(echo "$$CDK_LIST_OUTPUT" | grep -o '[^ ]*Service-personal[^ ]*' | head -n 1); \
		if [ -z "$$DEV_SERVICE_STACK" ]; then \
			echo "Error: No -personal service stack found."; \
			exit 1; \
		fi; \
		echo "Deploying service stack: $$DEV_SERVICE_STACK"; \
		AWS_DEV_ACCOUNT=$(AWS_DEV_ACCOUNT) AWS_DEV_REGION=$(AWS_DEV_REGION) brazil-build cdk deploy $$DEV_SERVICE_STACK; \
	}

# Help message
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make deploy       - Run build, list, bootstrap, and deploy in one step"
	@echo "  make help         - Display this help message"
