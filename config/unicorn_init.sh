#!/bin/bash
# unicorn hot restart script --nick@crunched.com
APP_ROOT = "/home/ubuntu/apps/ubiquity"
#pid "#{root}/tmp/pids/unicorn.pid"
source /home/ubuntu/.rvm/environments/ruby-2.0.0-p0
PID="/home/ubuntu/apps/ubiquity/tmp/pids/unicorn.pid"
export RAILS_ENV=production
OLDPID="$PID.oldbin"
# how long should we let the hot restart go before we call it a fail
TIMEOUT=240 # seconds
# command to kick start unicorn if things arent working out
UNICORN_START="bundle exec unicorn -D -c /home/ubuntu/apps/ubiquity/config/unicorn.rb -E production"
 
# monit start unicorn? /etc/init.d/unicorn start? whatever you want
 
###################################
# check if unicorn isn't running
if [ ! -f $PID ]; then
  echo "[ERROR] No Unicorn PID found, attempting to start"
  eval $UNICORN_START
  exit 1
fi
 
# make sure a hot restart isnt in progress
if [ -f $OLDPID ]; then
  echo "[ERROR] A Unicorn hot restart appears to already be in progress, exiting"
  exit 1
fi
 
 get the PID of the current unicorn
CURRUNI=`cat $PID`
 
# verify the PID is actually running Unicorn
if ! grep --quiet -a "^unicorn master" /proc/$CURRUNI/cmdline; then
  echo "[ERROR] Unicorn does not appear to be running, attempting to start"
  eval $UNICORN_START
  exit 1
fi
 
# send USR2
echo "Kicking off a Unicorn hot restart for pid $CURRUNI"
kill -USR2 $CURRUNI
 
n=0
 
while (("$n" < "$TIMEOUT")); do
  echo -n '.'
  sleep 1 # always sleep on first run, we're too fast
  n=$(($n + 1))
  NEWUNI=`cat $PID 2>/dev/null` # if it hasnt started yet, no biggie
 
 # restart hasn't occured yet, no biggie
  if [ "$NEWUNI" = "$CURRUNI" ]; then
    continue
  fi
 
  # but what if the new PID is different....
  # is our old unicorn still alive?
  if grep --quiet -a "^unicorn master" /proc/$CURRUNI/cmdline 2>/dev/null; then
    continue
  fi
 
  # it's not! ok make sure its a unicorn master
  if ! grep --quiet -a "^unicorn master" /proc/$NEWUNI/cmdline; then
    # it's still starting, give it some time
    continue
  fi
 
  # woo hoo we've hot restarted!
  echo
  echo "Hot restart finished in $n seconds, new Unicorn is pid $NEWUNI!"
  exit 0
done
 
# uhoh we've reached here, the hot restart has failed
echo
echo "[ERROR] Timeout of $TIMEOUT seconds reached! Hot restart failed!"
# optional >>>>>>
echo "Attempting hard restart of Unicorn!"
kill -QUIT `cat $PID`
eval $UNICORN_START
# <<<<<< optional
