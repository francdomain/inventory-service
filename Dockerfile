# Build stage
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o inventory-service

# Final stage
FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/inventory-service .
EXPOSE 8080
CMD ["./inventory-service"]



# # Build stage
# FROM golang:1.22-alpine AS builder

# WORKDIR /app

# # Copy go mod files
# COPY go.mod go.sum ./
# RUN go mod download

# # Copy source code
# COPY . .

# # Build the application
# RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o inventory-service .

# # Final stage
# FROM alpine:3.19.1

# # Install CA certificates for HTTPS and security updates
# RUN apk --no-cache add ca-certificates && \
#   apk upgrade --no-cache

# WORKDIR /root/

# # Copy binary from builder
# COPY --from=builder /app/inventory-service .

# # Create non-root user for security
# RUN adduser -D -g '' appuser && \
#   chown appuser:appuser /root/inventory-service

# # Switch to non-root user
# USER appuser

# # Expose port
# EXPOSE 8080

# # Run the binary
# CMD ["./inventory-service"]