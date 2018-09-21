# go-test-multi-stage-build
Go multi stage build practice 

# Objective
Practice how to enable multi stage build in golang.

# Run
1. `go get -u github.com/golang/dep/cmd/dep`
1. `dep ensure`
1. `docker build . -t go2docker`
1. `docker run --name demo go2docker`

# Expected result
![result](https://i.imgur.com/VURu2Zs.png)

# Vendor file handle
https://ops.tips/blog/dockerfile-golang/

# Google image reference
1. https://github.com/GoogleCloudPlatform/distroless
1. https://console.cloud.google.com/gcr/images/cloud-marketplace-containers/GLOBAL/google
1. https://console.cloud.google.com/gcr/images/google-appengine/GLOBAL
1. https://console.cloud.google.com/gcr/images/cloud-builders

# Apline vs deb

# Reference
1. https://github.com/GoogleCloudPlatform/cloud-builders/tree/master/go
1. https://github.com/GoogleCloudPlatform/golang-docker/tree/master/runtime-builder
1. https://github.com/GoogleContainerTools/base-images-docker
1. https://github.com/bitnami/minideb

# About go dep
https://github.com/golang/dep

# Docker images size comparison ( image )
![size](https://i.imgur.com/Q6qXegJ.png)

# Docker images size comparison ( text )
```bash
○ → docker image ls
REPOSITORY                                           TAG                 IMAGE ID            CREATED             SIZE
gcr.io/cloud-builders/go                             debian              b20bb9fbb50d        4 hours ago         796MB
gcr.io/cloud-builders/go                             alpine              db491b449a7f        4 hours ago         539MB
gcr.io/cloud-builders/go                             latest              db491b449a7f        4 hours ago         539MB
bitnami/minideb                                      latest              7ed9c6be650e        16 hours ago        53.7MB
golang                                               alpine              233ed4ed14bf        9 days ago          310MB
alpine                                               latest              196d12cf6ab1        9 days ago          4.41MB
golang                                               latest              fb7a47d8605b        2 weeks ago         776MB
debian                                               stable-slim         414b5dbe710f        2 weeks ago         55.3MB
gcr.io/gcp-runtimes/go1-builder                      latest              4364ab6018d2        3 weeks ago         490MB
gcr.io/google-appengine/golang                       latest              56521497699d        5 months ago        418MB
gcr.io/gcp-runtimes/ubuntu_16_0_4                    latest              37b1fb5420cd        48 years ago        138MB
launcher.gcr.io/google/ubuntu16_04                   latest              37b1fb5420cd        48 years ago        138MB
gcr.io/distroless/base                               latest              1358ac6604c5        48 years ago        16.6MB
gcr.io/cloud-marketplace-containers/google/debian9   latest              db73c6a8f103        48 years ago        103MB
launcher.gcr.io/google/debian9                       latest              db73c6a8f103        48 years ago        103MB
```


# go mod location
The build cache ($GOCACHE, defaulting to $HOME/.cache/go-build) is for storing recent compilation results, so that if you need to do that exact compilation again, you can just reuse the file. The build cache holds entries that are like “if you run this exact compiler on these exact inputs. this is the output you’d get.” If the answer is not in the cache, your build uses a little more CPU to run the compiler nstead of reusing the output. But you are guaranteed to be able to run the compiler instead, since you have the exact inputs and the compiler binary (or else you couldn’t even look up the answer in the cache).

The module cache ($GOPATH/src/mod, defaulting to $HOME/go/src/mod) is for storing downloaded source code, so that every build does not redownload the same code and does not require the network or the original code to be available. The module cache holds entries that are like “if you need to download mymodule@v1.2.3, here are the files you’d get.” If the answer is not in the cache, you have to go out to the network. Maybe you don’t have a network right now. Maybe the code has been deleted. It’s not anywhere near guaranteed that you can redownload the sources and also get the same result. Hopefully you can, but it’s not an absolute certainty like for the build cache. (The go.sum file will detect if you get a different answer on re-download, but knowing you got the wrong bits doesn’t help you make progress on actually building your code. Also these paths end up in file-line information in binaries, so they show up in stack traces, and the like and feed into tools like text editors or debuggers that don’t necessarily know how to trigger the right cache refresh.)

# Reference 
https://dave.cheney.net/2018/07/14/taking-go-modules-for-a-spin
