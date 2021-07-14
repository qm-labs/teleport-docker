FROM golang:alpine AS builder
RUN apk add zip alpine-sdk linux-headers git
RUN mkdir -p $GOPATH/src/github.com/gravitational
WORKDIR $GOPATH/src/github.com/gravitational
RUN git clone --depth 1 --branch v6.2.7 https://github.com/gravitational/teleport.git
RUN cd teleport && make full && mkdir /teleport && cp build/* /teleport

FROM alpine
COPY --from=builder /teleport/* /usr/local/bin
