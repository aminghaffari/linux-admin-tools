#!/bin/bash

default_interface() {
    ip route | awk '/default/ {print $5; exit}'
}

default_gateway() {
    ip route | awk '/default/ {print $3; exit}'
}

ipv4_address() {
    local iface="$1"
    ip -4 addr show "$iface" | awk '/inet / {print $2; exit}'
}

ipv6_address() {
    local iface="$1"
    ip -6 addr show "$iface" | awk '/inet6 / && $2 !~ /^fe80/ {print $2; exit}'
}

interface_state() {
    local iface="$1"
    cat "/sys/class/net/$iface/operstate" 2>/dev/null
}

interface_mtu() {
    local iface="$1"
    cat "/sys/class/net/$iface/mtu" 2>/dev/null
}

interface_mac() {
    local iface="$1"
    cat "/sys/class/net/$iface/address" 2>/dev/null
}

ping_host() {
    ping -c 3 -W 2 "$1" >/dev/null 2>&1
}

ping_avg() {
    ping -c 3 -W 2 "$1" 2>/dev/null | awk -F'/' '/rtt|round-trip/ {print $5}'
}

dns_servers() {
    grep '^nameserver' /etc/resolv.conf | awk '{print $2}'
}

resolve_host() {
    getent hosts "$1" >/dev/null 2>&1
}

public_ip() {
    curl -s --max-time 5 https://ifconfig.me
}
default_route() {
    ip route | grep '^default'
}

listening_ports() {
    ss -tuln 2>/dev/null | awk 'NR==1 || /LISTEN|UNCONN/' | head -n 20
}

interface_errors() {
    local iface="$1"
    ip -s link show "$iface" 2>/dev/null
}

packet_loss() {
    ping -c 3 -W 2 "$1" 2>/dev/null | awk -F',' '/packet loss/ {
        gsub(/^[ \t]+|[ \t]+$/, "", $3)
        gsub("packet loss", "", $3)
        gsub(/^[ \t]+|[ \t]+$/, "", $3)
        print $3
    }'
}
