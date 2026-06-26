#!/bin/bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

require_command() {
    if ! command_exists "$1"; then
        echo "Missing required command: $1"
        exit 1
    fi
}

is_root() {
    [ "$EUID" -eq 0 ]
}

timestamp() {
    date +"%Y-%m-%d %H:%M:%S"
}

hostname_short() {
    hostname
}

kernel_version() {
    uname -r
}

os_name() {
    grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"'
}
