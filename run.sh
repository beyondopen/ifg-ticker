#!/bin/bash
# 
# Runs track-the-news but ensure it always only runs once. Used as a service (which ensures it only runs once)
set -e
export PYTHONIOENCODING=utf8;
while : ; do
  everthink_okay=$(python "safeguard.py")
  if [ "$everthink_okay" != "True" ]
  then
      echo "Aborting. Something is wrong with your timeline."
      echo "Something is wrong. Please fix me." | mail -s "[IFG-Ticker] HALP!" "hi+ifgticker@jfilter.de"
      exit
  else
    echo "timeline is sane. run trackthenews."
    sleep 30
  fi
done
