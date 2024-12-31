FROM golang:1.19-alpine as builder

RUN apk add --no-cache git build-base
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY cmd ./cmd
COPY internal ./internal
COPY configs ./configs
COPY reports ./reports
COPY Makefile ./

RUN CGO_ENABLED=0 GOOS=linux go build -o server ./cmd/main.go

FROM alpine:3.18

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app

COPY --from=builder /app/server /app/server
COPY --from=builder /app/configs /app/configs
COPY --from=builder /app/reports /app/reports

COPY ./migrations /app/migrations

RUN chown -R appuser:appgroup /app

USER appuser

CMD ["/app/server", "/app/configs/config.json"]
