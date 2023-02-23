.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

.PHONY: test
test: ## run the unit test
	GO111MODULE=on go test -v -cover -count=1 ./...

.PHONY: run
run: ## start the app
	GO111MODULE=on go run ./main.go

.PHONY: dev
dev: ## hot relaod dev
	modd

.PHONY: coverage
coverage: ## run the unit test with code coverage
	go test -cover -count=1 ./... -coverprofile coverage.out && go tool cover -func=coverage.out && go tool cover -html=coverage.out -o coverage.html

.PHONY: coverage
coveragehtml: coverage ## generate code coverage file in html format
	go tool cover -html=coverage.out
