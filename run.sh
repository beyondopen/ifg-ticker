#/bin/bash
set -e

while : ; do
  /home/jfilter/.local/bin/trackthenews /home/jfilter/code/ifg-feed/ttnconfig/
  sleep 30
done &
