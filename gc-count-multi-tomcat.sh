#!/bin/bash

# This will work with mutliple tomcat's installed and looks for /var/log/tomcat/tomcat1,/var/log/tomcat/tomcat2
# Ensure you match up your paths/folders with your install

APP="YOUR_APP_NAME";
# Look for 4 instances of tomcat1 ... tomcat4
INSTANCE="tomcat{1..4}"
INSTANCES=$(eval echo $INSTANCE)

GCFILE="gc.log";
TOMCAT_FOLDER="/var/log/tomcat6";

# Work out date for 1 hour
CDATE=$(date +%Y-%m-%d"T" -d "0 days ago")
LTIME=$(date --date "1 hour ago" +%H":"%M)
NTIME=$(date --date "0 hour ago" +%H":"%M)
pattern=$CDATE$LTIME
pattern2=$CDATE$NTIME

server=$(hostname -s)

function return_gc_count() {
        for ids in $INSTANCES; do
                LOGFILE=$TOMCAT_FOLDER/$ids/$GCFILE
                #awk  -v p=$pattern -vp2=$pattern2 -v id=$ids 'BEGIN {FC=0; } $0~p,$0~p2 {  if ($0 ~ "Full GC" ) { FC++; } }END { print id":"FC; }' $LOGFILE
                tail -n 10000 $LOGFILE |awk  -v p=$pattern -vp2=$pattern2 -v id=$ids 'BEGIN {FC=0; } $0~p,$0~p2 {  if ($0 ~ "Full GC" ) { FC++; } }END { print id":"FC; }' 
        done
}

RES=$(return_gc_count)
GRES=$(echo $RES|tr ":" "=")

echo "$server": "$APP"-FULLGC: "$LTIME"-"$NTIME:"$RES"|"$GRES
