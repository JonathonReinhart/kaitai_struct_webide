################################################################################
# Build
FROM alpine:3.14 AS builder
WORKDIR /ksw_src
RUN apk add \
    git \
    npm
COPY . ./
RUN npm install \
    && ./build

################################################################################
# Serve
FROM alpine:3.14 AS server
WORKDIR /ksw
# TODO: Use another webserver for simple static content?
RUN apk add npm && npm install -g http-server
COPY --from=builder /ksw_src/out ./

EXPOSE 80
CMD http-server -p 80

# Run with:   docker run --rm -it -p 8080:80
