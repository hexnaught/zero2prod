FROM rust:1.73.0 AS base

WORKDIR /app

RUN apt update && apt install lld clang -y

COPY Cargo.toml .
COPY Cargo.lock .
RUN cargo update --locked

COPY . .

ENV SQLX_OFFLINE true
RUN cargo build --locked --release

ENV APP_ENVIRONMENT production

ENTRYPOINT ["./target/release/zero2prod"]
