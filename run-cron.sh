#!/bin/bash
# 
# Runs track-the-news but ensure it always only runs once. Used in the crontab.
set -e
export PYTHONIOENCODING=utf8;
while : ; do
  if pgrep -f "trackthenews" &>/dev/null; then
      echo "trackthenews is already running. exiting."
      exit
  else
    /home/jfilter/.local/bin/trackthenews /home/jfilter/code/ifg-feed/ttnconfig/
    sleep 30
  fi
done &
