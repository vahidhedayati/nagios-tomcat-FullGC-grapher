#!/bin/bash

APP="YOU_APP_NAME";


TOMCAT_FOLDER="/var/log/tomcat6";

# Your gc file name
GCFILE="gc.log";

# Work out date for 1 hour ago
CDATE=$(date +%Y-%m-%d"T" -d "0 days ago")
LTIME=$(date --date "1 hour ago" +%H":"%M)
NTIME=$(date --date "0 hour ago" +%H":"%M)
pattern=$CDATE$LTIME
pattern2=$CDATE$NTIME

# Current server name 
server=$(hostname -s)


function return_gc_count() {
        
                LOGFILE=$TOMCAT_FOLDER/$GCFILE
                tail -n 10000 $LOGFILE |awk  -v p=$pattern -vp2=$pattern2 -v id=$ids 'BEGIN {FC=0; } $0~p,$0~p2 {  if ($0 ~ "Full GC" ) { FC++; } }END { print id":"FC; }' 
}

RES=$(return_gc_count)
GRES=$(echo $RES|tr ":" "=")

echo "$server": "$APP"-FULLGC: "$LTIME"-"$NTIME:"$RES"|"$GRES
