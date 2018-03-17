#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'
DRAFT_ROOT="${BASH_SOURCE[0]%/*}/.."

cd "$DRAFT_ROOT"

run_unit_test() {
  echo "Running unit tests"
  go get -u github.com/jstemmer/go-junit-report
  trap "go-junit-report <${TEST_RESULTS}/go-test.out > ${TEST_RESULTS}/go-test-report.xml" EXIT
  make test-unit | tee ${TEST_RESULTS}/go-test.out
}

run_style_check() {
  echo "Running style checks"
  make test-lint
}

run_unit_test
run_style_check
