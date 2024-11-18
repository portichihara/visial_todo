FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY . .

# 必要なパッケージのインストール
RUN apk add --no-cache git

# 依存関係の更新とダウンロード
RUN go mod tidy
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app

FROM alpine:latest

WORKDIR /app
COPY --from=builder /app/app .
COPY templates/ templates/
COPY static/ static/

EXPOSE 8080
CMD ["./app"]