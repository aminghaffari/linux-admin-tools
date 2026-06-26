#!/bin/bash

critical_count() {
    journalctl -b -p 3 -n 200 --no-pager 2>/dev/null | wc -l
}

boot_warning_count() {
    journalctl -b -p warning..alert -n 200 --no-pager 2>/dev/null | wc -l
}

kernel_warning_count() {
    journalctl -k -p warning..alert -n 200 --no-pager 2>/dev/null | wc -l
}

oom_count() {
    journalctl -k -n 500 --no-pager 2>/dev/null | grep -Eic "out of memory|oom|killed process"
}

auth_failure_count() {
    journalctl -b -n 500 --no-pager 2>/dev/null | grep -Eic "failed password|authentication failure|invalid user"
}

recent_critical() {
    journalctl -b -p 3 -n 10 --no-pager 2>/dev/null
}
