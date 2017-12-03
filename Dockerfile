# Start by building the application.
FROM golang:1.9 as build

WORKDIR /go/src/app
COPY . .

# https://golang.org/cmd/go/#hdr-Compile_packages_and_dependencies
# More go build document
RUN CGO_ENABLE=0 GOOS=linux \
  go build \
  -tags netgo \
  -installsuffix netgo,cgo \
  -v -a \
  -ldflags '-extldflags "-static"' \ 
  -o app && \
  mv ./app /go/bin/app

# This section aims to do the go dep & go build
# RUN go-wrapper download   # "go get -d -v ./..."
# RUN go-wrapper install
# End section
# Reference https://github.com/GoogleCloudPlatform/distroless

# Now copy it into our base image.
FROM gcr.io/distroless/base
COPY --from=build /go/bin/app /
CMD ["/app"]
