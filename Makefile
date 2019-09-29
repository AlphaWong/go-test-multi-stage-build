test:
	GO111MODULE=on go test -v -cover -count=1 ./...
run:
	GO111MODULE=on go run ./main.go

dev:
	modd

coverage:
	go test -cover -count=1 ./... -coverprofile coverage.out && go tool cover -func=coverage.out && go tool cover -html=coverage.out -o coverage.html

coveragehtml: coverage
	go tool cover -html=coverage.out
