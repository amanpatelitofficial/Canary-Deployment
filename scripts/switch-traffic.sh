#!/bin/bash
# Usage: ./switch-traffic.sh blue|green

TARGET=$1
if [[ "$TARGET" == "blue" ]]; then
  BLUE=100
  GREEN=0
elif [[ "$TARGET" == "green" ]]; then
  BLUE=0
  GREEN=100
else
  echo "Usage: $0 blue|green"
  exit 1
fi

kubectl patch httproute myapp-route -p "{"spec":{"rules":[{"backendRefs":[{"name":"app-blue-svc","port":80,"weight":$BLUE},{"name":"app-green-svc","port":80,"weight":$GREEN}]}]}}"
echo "Traffic switched: Blue=$BLUE%, Green=$GREEN%"