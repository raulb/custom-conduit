# Start with a golang base
FROM golang:1.24-bullseye AS base

# Build the full app binary
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 make build

# Copy built binaries to production slim image.
FROM alpine:3.21 AS final
# HTTP API
EXPOSE 8080/tcp
# gRPC API
EXPOSE 8084/tcp
WORKDIR /app
COPY --from=base /app/conduit /app
CMD ["/app/conduit", "run", "--preview.pipeline-arch-v2", "--log.level=debug"]
