#/bin/bash
set -e

while : ; do
  if pgrep -f "trackthenewsy" &>/dev/null; then
      echo "trackthenews is already running. exiting."
      exit
  else
    /home/jfilter/.local/bin/trackthenews /home/jfilter/code/ifg-feed/ttnconfig/
    sleep 30
  fi
done &
