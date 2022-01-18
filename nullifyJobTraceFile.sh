## Nullify /u02/app/oracle/admin/11.2.0.4/diag/rdbms/adcmqsdb/adcmqsdb4/trace/*j0*.trc files greater than 20GB
00 * * * * /home/oracle/scripts/nullifyJobTraceFile.sh /dev/null 2>&1

nullifyJobTraceFile.sh
----------------------
#!/bin/bash
# Nullify /u02/app/oracle/admin/11.2.0.4/diag/rdbms/adcmqsdb/adcmqsdb4/trace/*j0*.trc files
# with size > 20GB
#

if [ -e /home/oracle/scripts/makeNull.sh ]
then
rm /home/oracle/scripts/makeNull.sh
fi

threshold=21474836480

du -sh /u02/app/oracle/admin/11.2.0.4/diag/rdbms/adcmqsdb/adcmqsdb1/trace/*j0*.trc | grep G > /home/oracle/scripts/bigtrace.txt
if [ -e /home/oracle/scripts/bigtrace.txt ]
then

while IFS=$'\t' read -r -a fileInput
do

  myFileSizeCheck=$(stat -c %s "${fileInput[1]}")

  if [ $myFileSizeCheck -gt $threshold ]
  then
  echo "cat /dev/null > ${fileInput[1]}" >> /home/oracle/scripts/makeNull.sh
  fi

done < "/home/oracle/scripts/bigtrace.txt"

if [ -e /home/oracle/scripts/bigtrace.txt ]
then
rm /home/oracle/scripts/bigtrace.txt
fi

if [ -e /home/oracle/scripts/makeNull.sh ]
then
chmod 770 /home/oracle/scripts/makeNull.sh
sh /home/oracle/scripts/makeNull.sh
fi

fi



