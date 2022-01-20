#!/bin/bash
# File : gzip_asmaudit.log.1.sh
# Desc : Find and gzip /var/log/asmaudit.log.1 if it's > 1.0 GB

threshold=1073741824

if [ ! -f "/var/log/asmaudit.log.1" ]; then
    echo "asmaudit.log.1 does not exist."
    exit 0
fi

FileSizeCheck=$(stat -c %s "/var/log/asmaudit.log.1")

if [ $FileSizeCheck -gt $threshold ]
then
   find /var/log -iname "asmaudit.log.1" -exec gzip {} \;
fi