#!/bin/bash
# 
# Runs trackthenews with a safeguard. Used as a service (which ensures it only runs once.)
set -e
export PYTHONIOENCODING=utf8;
while : ; do
  everthing_okay=$(python "/home/jfilter/code/ifg-feed/safeguard.py")
  echo $everthing_okay
  if [ "$everthing_okay" == "False" ]
  then
      echo "Aborting. Something is wrong with your timeline."
      echo "Something is wrong. Please fix me." | mail -s "[IFG-Ticker] HALP!" "hi+ifgticker@jfilter.de"
      exit
  else
    echo "timeline is sane. run trackthenews."
    timeout 5h /home/jfilter/.local/bin/trackthenews /home/jfilter/code/ifg-feed/ttnconfig/
    sleep 90
    
    # keep only the last 100k entries. clean with a chance of 1/100.
    # never delete tweeted articles.
    if (( RANDOM % 100 -eq 0 ))
    then
      cd /home/jfilter/code/ifg-feed/ttnconfig/ &&
      sqlite3 -batch trackthenews.db "delete from articles
        where id not in (
            select id
            from articles
            order by id desc
            limit 100000
        ) AND tweeted = 0" 
    fi
  fi
done
