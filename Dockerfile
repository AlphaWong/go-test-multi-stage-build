# Start by building the application.
FROM golang:alpine as build

RUN apk add --no-cache git build-base && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache upx

WORKDIR /go/src/app
COPY . .

# This section aims to do the go dep & go build ( Download the dependency )
# Go tool dep https://github.com/golang/dep
# RUN go-wrapper download   # "go get -d -v ./..."
# RUN go-wrapper install
# End section
# Reference https://github.com/GoogleCloudPlatform/distroless
RUN go get -u github.com/golang/dep/cmd/dep
RUN dep ensure -v -vendor-only


# https://golang.org/cmd/go/#hdr-Compile_packages_and_dependencies
# More go build document
# About the usage of upx https://gitlab.com/snippets/1689274
RUN CGO_ENABLE=0 GOOS=linux \
  go build \
  -tags netgo \
  -installsuffix netgo,cgo \
  -v -a \
  -ldflags '-s -w -extldflags "-static"' \ 
  -o app

# Compress go binary
RUN upx --ultra-brute -qq app && \
  upx -t app && \
  mv ./app /go/bin/app

# Now copy it into our base image.
FROM gcr.io/distroless/base
COPY --from=build /go/bin/app /
ENTRYPOINT ["/app"]
