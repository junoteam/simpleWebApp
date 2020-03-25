FROM golang:1.14 as builder

WORKDIR /go/src/simpleWebApp
COPY . .

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -v -o simpleWebApp

# multistage build

FROM alpine:latest
RUN apk --no-cache add ca-certificates
RUN mkdir /templates

COPY --from=builder /go/src/simpleWebApp/simpleWebApp /simpleWebApp
COPY --from=builder /go/src/simpleWebApp/templates/simpleweb.tmpl /templates

EXPOSE 8080
CMD ["/simpleWebApp"]