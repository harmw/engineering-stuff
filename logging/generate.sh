#!/usr/bin/env bash
# Let's create some fake logs here, using the following schema:
#  <timestamp> <ip address> <http path> <http verb> <user agent>
#
# Example:
#  [29/Sep/2024:10:20:48+0100] 192.168.21.34 /healthz GET Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)
#

LOG="httpd.log"
IP="192.0.2."

echo "resetting log file at $LOG"
echo "<timestamp> <ip address> <http path> <http verb> <user agent>" > $LOG

echo "generating logs"
for i in $(seq 1 100); do
  ip="${IP}$i"
  chance=$((1 + $RANDOM % 10))

  # here we test chance and use that to write out some fake request
  # we also test it to skew some ip addresses and up their requests
  [[ $chance < 3 ]] && ip="${IP}99"
  [[ $chance < 2 ]] && ip="${IP}42"

  [[ $chance < 5 ]] && echo "[$(date)] $ip /foo5 GET Mozilla/5.0 (something something user-agent)" >> $LOG
  [[ $chance < 4 ]] && echo "[$(date)] $ip /foo4 POST Mozilla/5.0 (something something user-agent)" >> $LOG
  [[ $chance < 3 ]] && echo "[$(date)] $ip /foo3 GET Mozilla/5.0 (something something user-agent)" >> $LOG
  [[ $chance < 2 ]] && echo "[$(date)] $ip /foo2 GET Mozilla/5.0 (something something user-agent)" >> $LOG
  [[ $chance < 1 ]] && echo "[$(date)] $ip /foo1 HEAD Mozilla/5.0 (something something user-agent)" >> $LOG
done

echo "done"
wc -l $LOG
