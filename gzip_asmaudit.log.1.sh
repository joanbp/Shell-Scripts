#!/bin/bash
# File : gzip_asmaudit.log.1.sh
# Desc : Find and gzip /var/log/asmaudit.log.1 if it's > 1.0 GB
#        Find and nullify /var/log/asmaudit.log if it's > 1.5 GB

threshold1=1073741824
threshold2=1610612736

# Find and gzip /var/log/asmaudit.log.1 if it's > 1.0 GB
if [ -f "/var/log/asmaudit.log.1" ]; then
	FileSizeCheck=$(stat -c %s "/var/log/asmaudit.log.1")

	if [ $FileSizeCheck -gt $threshold1 ]
	then
   		find /var/log -iname "asmaudit.log.1" -exec gzip {} \;
	fi
fi

# Find and nullify /var/log/asmaudit.log if it's > 1.5 GB
if [ -f "/var/log/asmaudit.log" ]; then
	FileSizeCheck=$(stat -c %s "/var/log/asmaudit.log")
	
        if [ $FileSizeCheck -gt $threshold2 ]
	then
   		cat /dev/null > /var/log/asmaudit.log
	fi
fi
