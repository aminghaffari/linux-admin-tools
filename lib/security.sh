#!/bin/bash

firewall_status() {
    if command -v ufw >/dev/null 2>&1; then
        sudo -n ufw status 2>/dev/null | head -n 1 || echo "Permission required"
    else
        echo "UFW not installed"
    fi
}

ssh_root_login() {
    sshd -T 2>/dev/null | awk '/^permitrootlogin / {print $2}'
}

ssh_password_auth() {
    sshd -T 2>/dev/null | awk '/^passwordauthentication / {print $2}'
}

ssh_port() {
    sshd -T 2>/dev/null | awk '/^port / {print $2}'
}

uid0_users() {
    awk -F: '$3==0 {print $1}' /etc/passwd
}

shell_users() {
    awk -F: '$7 !~ /(nologin|false)/ {print $1}' /etc/passwd
}

empty_password_users() {
    sudo -n awk -F: '($2==""){print $1}' /etc/shadow 2>/dev/null || echo "Permission required"
}

sudo_users() {
    getent group sudo | cut -d: -f4
}

security_updates() {
    if command -v apt >/dev/null 2>&1; then
        apt list --upgradable 2>/dev/null | grep -ic security
    else
        echo "N/A"
    fi
}
