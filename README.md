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
https://github.com/GoogleCloudPlatform/distroless

# About go dep
https://github.com/golang/dep

# Images compare ( size )
![docker images size](https://i.imgur.com/Ohr7kmJ.png)

# go mod location
The build cache ($GOCACHE, defaulting to $HOME/.cache/go-build) is for storing recent compilation results, so that if you need to do that exact compilation again, you can just reuse the file. The build cache holds entries that are like “if you run this exact compiler on these exact inputs. this is the output you’d get.” If the answer is not in the cache, your build uses a little more CPU to run the compiler nstead of reusing the output. But you are guaranteed to be able to run the compiler instead, since you have the exact inputs and the compiler binary (or else you couldn’t even look up the answer in the cache).

The module cache ($GOPATH/src/mod, defaulting to $HOME/go/src/mod) is for storing downloaded source code, so that every build does not redownload the same code and does not require the network or the original code to be available. The module cache holds entries that are like “if you need to download mymodule@v1.2.3, here are the files you’d get.” If the answer is not in the cache, you have to go out to the network. Maybe you don’t have a network right now. Maybe the code has been deleted. It’s not anywhere near guaranteed that you can redownload the sources and also get the same result. Hopefully you can, but it’s not an absolute certainty like for the build cache. (The go.sum file will detect if you get a different answer on re-download, but knowing you got the wrong bits doesn’t help you make progress on actually building your code. Also these paths end up in file-line information in binaries, so they show up in stack traces, and the like and feed into tools like text editors or debuggers that don’t necessarily know how to trigger the right cache refresh.)

# Reference 
https://dave.cheney.net/2018/07/14/taking-go-modules-for-a-spin
