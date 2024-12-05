#!/bin/bash
#


#
#   Push any changes to university files
#

UNI_LOG="/home/omega/Documents/University/log"
echo "--------------------" >> $UNI_LOG
date >> $UNI_LOG
source /home/omega/Documents/University/push.sh >> $UNI_LOG 2>&1 
echo "--------------------" >> $UNI_LOG



# shutdown system
shutdown now
