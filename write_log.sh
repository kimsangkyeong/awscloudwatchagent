#!/bin/sh

ix=1

#logdir="/home/ec2-user/apps"
logdir="/var/log/apps"
logfile="$logdir/eai_test"
while [ "$ix" -lt 400 ]
do
    if ! [ -d $logdir ]
    then
        mkdir $logdir
    fi
    if [ -e $logfile ]
    then
      echo " $ix - `date` : good " >>  $logfile
      echo "exists"
    else
      echo " $ix - `date` : create " >  $logfile
      echo "not "
    fi
    echo " ix : $ix "
    ix=$(expr $ix + 1)
    sleep 2
done
