# Project Setup

## Faster Linking

See `.cargo/config.toml`

## Code Coverage

```sh
cargo install cargo-tarpaulin
```
```sh
# ignore coverage of test files
cargo tarpaulin --ignore-tests
```

## Linting

```sh
rustup component add clippy
```
```sh
cargo clippy
# Fail clippy with warnings, useful in CI
cargo clippy -- -D warnings
```

### Muting Clippy

Muting is done via directive on a per rule basis or can be done in `clippy.toml` or a project level.

```rust
// specific scope level
#[allow(clippy::lint_name)]
// project level
#![allow(clippy::lint_name)]
```

## Formatting

```sh
rustup component add rustfmt
```

```sh
cargo fmt
cargo fmt -- --check
```

## Security Scanning

### Cargo Audit

```sh
cargo install cargo-audit
```
```sh
cargo audit
```

### Cargo Deny

```sh
cargo install --locked cargo-deny && cargo deny init && cargo deny check
```

## Expanding Macros

```sh
cargo expand
```

## Cargo un-used deps

```sh
cargo +nightly udeps
```

# Tooling

## sqlx-cli

```sh
cargo install --version="~0.7" sqlx-cli --no-default-features --features rustls,postgres
```

```sh
sqlx --help
```

## Pipe to bunyan for better output

Bunyan allows easier formatting and reading of logs at the CLI.

```sh
# We are using the `bunyan` CLI to prettify the outputted logs
# The original `bunyan` requires NPM, but you can install a Rust-port with
# `cargo install bunyan`
TEST_LOG=true cargo test health_check_works | bunyan
```

<!-- https://blog.rust-lang.org/2018/05/10/Rust-1.26.html#impl-trait -->
## Requests

```sh
curl -v http://127.0.0.1:8000/health_check
curl -i -X POST -d 'email=thomas_mann@hotmail.com&name=Tom' http://127.0.0.1:8000/subscriptions
```
