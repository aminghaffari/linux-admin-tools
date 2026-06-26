#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"

line() {
    printf '=%.0s' $(seq 1 80)
    echo
}

title() {
    clear
    echo -e "${BOLD}${CYAN}$1${RESET}"
    line
}

section() {
    echo
    echo -e "${BLUE}${BOLD}$1${RESET}"
    line
}

ok() {
    echo -e "${GREEN}[ OK ]${RESET} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${RESET} $1"
}

fail() {
    echo -e "${RED}[FAIL]${RESET} $1"
}

info() {
    echo -e "${CYAN}[INFO]${RESET} $1"
}

kv() {
    printf "%-22s : %s\n" "$1" "$2"
}
