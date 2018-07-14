#!/bin/bash
# 
# Runs trackthenews with a safeguard. Used as a service (which ensures it only runs once.)
set -e
export PYTHONIOENCODING=utf8;
while : ; do
  everthing_okay=$(python "/home/jfilter/code/ifg-feed/safeguard.py")
  if [ "$everthing_okay" != "True" ]
  then
      echo "Aborting. Something is wrong with your timeline."
      echo "Something is wrong. Please fix me." | mail -s "[IFG-Ticker] HALP!" "hi+ifgticker@jfilter.de"
      exit
  else
    echo "timeline is sane. run trackthenews."
    timeout 5h /home/jfilter/.local/bin/trackthenews /home/jfilter/code/ifg-feed/ttnconfig/
    sleep 30
  fi
done
