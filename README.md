# Project Setup

## Faster Linking

See `.cargo/config.toml`

## Code Coverage

```sh
# Install tarpaulin utility/plugin
cargo install cargo-tarpaulin
# ignore coverage of test files
cargo tarpaulin --ignore-tests
```

## Linting

```sh
# Install the clippy for linting
rustup component add clippy
# Run clippy to lint code
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
# Install rustfmt for formatting
rustup component add rustfmt
# Run the formatter
cargo fmt
cargo fmt -- --check
```

## Security Scanning

### Cargo Audit

Cargo `audit` is a utility that scans the project dependencies against an advisory database looking for vulnerable dependencies.

```sh
# Install cargo audit
cargo install cargo-audit
# Run cargo audit
cargo audit
```

### Cargo Deny

Cargo `deny` is a utility for scanning dependencies for vulnerabilities, but it goes a step further allowing configuration of certain registries only, an allow/deny list of Crates, licence checks and more.

There is a `deny.toml` configuration file in the project root with more information, or check the tooling's documentation.

```sh
cargo install --locked cargo-deny && cargo deny init && cargo deny check
```

## Expanding Macros

Cargo `expand` shows the project source code with all of the macros used 'expanded' and prints that source code to the terminal, allowing us to see exactly what the macro is doing.

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
# Install sqlx cli tooling with Cargo
cargo install --version="~0.7" sqlx-cli --no-default-features --features rustls,postgres
# Use the sqlx cli
cargo sqlx --help
```

### SQLX Prepare for 'Offline Mode'

This will generate a metadata file for `sqlx` to use with 'offline mode', allowing the app to build successfully without _having_ to connect to a database during the build step to verify queries.

Prepare does require the ability to connect to an actual postgres database.

```sh
cargo sqlx prepare --workspace
```

## Pipe to bunyan for better output

Bunyan allows easier formatting and reading of logs at the CLI.

```sh
# We are using the `bunyan` CLI to prettify the outputted logs
# The original `bunyan` requires NPM, but you can install a Rust-port with
# `cargo install bunyan`
TEST_LOG=true cargo test health_check_works | bunyan
```

# Running The App

## Configuration

[TODO: Configuration](#configuration)

## Local Machine

[TODO: Configuration.Local](#local-machine)

## Docker

You can build and run the app with the below Docker commands, for interacting with Postgres there must also be a Postgres database initialised and available with the connection information set up in the [Configuration](#configuration) step.

```sh
# Build the image
docker build --tag zero2prod --file Dockerfile .
# Run the app on port :8000
docker run -p 8000:8000 zero2prod
```

<!-- https://blog.rust-lang.org/2018/05/10/Rust-1.26.html#impl-trait -->
## Requests

```sh
curl -v http://127.0.0.1:8000/health_check
curl -i -X POST -d 'email=thomas_mann@hotmail.com&name=Tom' http://127.0.0.1:8000/subscriptions
```
