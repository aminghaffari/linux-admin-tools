#!/bin/bash

disk_usage() {
    df -h -x tmpfs -x devtmpfs --output=source,fstype,size,used,avail,pcent,target
}

disk_usage_high() {
    df -h -x tmpfs -x devtmpfs --output=source,pcent,target | awk 'NR>1 {
        gsub("%","",$2)
        if ($2 >= 80) print $0
    }'
}

inode_usage() {
    df -ih -x tmpfs -x devtmpfs
}

mount_points() {
    findmnt -rn \
    -t ext4,xfs,btrfs,zfs,vfat,f2fs \
    -o TARGET,SOURCE,FSTYPE
}

readonly_mounts() {
    findmnt -rn -o TARGET,OPTIONS | \
    grep '\<ro\>' | \
    grep -v '^/snap'
}

largest_dirs_var() {
    du -xh /var 2>/dev/null | sort -hr | head -n 10
}

largest_dirs_root() {
    du -xh / 2>/dev/null | sort -hr | head -n 10
}
