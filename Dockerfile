FROM rust:1.73.0 AS base

WORKDIR /app

RUN apt update && apt install lld clang -y

COPY . .

ENV SQLX_OFFLINE true
RUN cargo build --locked --release

# TODO: Statically link stdlib to run on scratch image?
# https://github.com/clux/muslrust
FROM debian:bookworm-slim as runner

WORKDIR /app

# Install OpenSSL - it is dynamically linked by some of our dependencies
# Install ca-certificates - it is needed to verify TLS certificates
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends openssl ca-certificates \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

COPY --from=base /app/target/release/zero2prod zero2prod

COPY configuration configuration
ENV APP_ENVIRONMENT production

ENTRYPOINT ["./zero2prod"]
