#!/usr/bin/env bash

cd "$(dirname "$0")"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ ! -f .env ]; then
  cp .env.default .env
  echo -e "${YELLOW}Sample configuration file is being generated for you.${NC}"
  echo -e "${YELLOW}Please check if the .env file matches your needs and run this command again.${NC}"
  exit
fi

source .env >/dev/null 2>&1

if [ "$1" = "start" ]; then
  echo -e "${GREEN}Starting LIGHTTPD container${NC}" && \
  docker-compose up --build -d && \
  echo -e "${GREEN}LIGHTTPD container has been started.${NC}"

elif [ "$1" = "stop" ]; then
  echo -e "${GREEN}Stopping LIGHTTPD container${NC}"
  docker-compose stop && echo -e "${GREEN}LIGHTTPD container has been stopped.${NC}"

elif [ "$1" = "reconf" ]; then
  echo -e "${GREEN}Reconfiguring LIGHTTPD container${NC}"
  docker-compose down && echo -e "${GREEN}LIGHTTPD container has been down and removed.${NC}"
  docker rmi docker-lighttpd-alpine_lighttpd:latest && echo -e "${GREEN}Image has been removed.${NC}"
  sleep 1
  "./$(basename "$0")" start


elif [ "$1" = "restart" ]; then
  "./$(basename "$0")" stop
  sleep 1
  "./$(basename "$0")" start

else
  echo -e "${RED}Usage: $0 start|stop|reconf|restart${NC}"
fi
