#!/bin/sh
# Shell script to monitor & inform the System Admin about the Disk Space
# It will send an email to $ADMIN, if the (free available) percentage of space is >= 90%.
# -------------------------------------------------------------------------
# Set admin email so that you can get email, It can be inserted using command line arguments
ADMIN=$1
# set alert level 90% is default
echo "Please Enter the Limit for DISK SPACE Usage: "
read ALERT
# Input taken from the user during the execution

# Exclude list of unwanted monitoring, if several partions then use "|" to separate the partitions.
# An example: EXCLUDE_LIST="/dev/hdd1|/dev/hdc5"
EXCLUDE_LIST="/auto/ripper"
#
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Function to inform the admin about the disk space, through email.
# This reads the STDIN input from the functional call, compare it with threshhold and send the report to admin if it exceeds.
function reportAdmin() {
while read output;
do
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1)
  partition=$(echo $output | awk '{print $2}')
  if [ $usep -ge $ALERT ] ; then
     echo "Running out of space \"$partition ($usep%)\" on server $(hostname), $(date)" | \
     mail -s "Alert: Almost out of disk space $usep%" $ADMIN
     echo "Disk Space is lower than 90% on \"$partition ($usep%)\""
     echo "Report Succesfully Sent to ADMIN"
  fi
done
}

if [ "$EXCLUDE_LIST" != "" ] ; then
  df -H | grep -vE "^Filesystem|tmpfs|cdrom|${EXCLUDE_LIST}" | awk '{print $5 " " $6}' | reportAdmin
else
  df -H | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}' | reportAdmin
fi
