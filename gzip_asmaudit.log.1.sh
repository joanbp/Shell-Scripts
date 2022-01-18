#!/bin/bash
# File : gzip_asmaudit.log.1.sh
# Desc : Find and gzip /var/log/asmaudit.log.1 if it's > 1.5 GB

threshold=1610612736
FileSizeCheck=$(stat -c %s "/var/log/asmaudit.log.1")

if [ $FileSizeCheck -gt $threshold ]
then
   find /var/log -iname "asmaudit.log.1" -exec gzip {} \;
fi