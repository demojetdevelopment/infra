#!/bin/bash

TEAMCITY_NETWORK=$(docker network ls --format="{{.Name}}" -f name=teamcity | grep teamcity$)

if [[ -z ${TEAMCITY_NETWORK} ]]
then
    # create teamcity network
    docker network create teamcity
fi

WINPTY=''
if [[ -n ${WINDIR} ]]
then
   echo "WINDIR is defined"
   WINPTY='winpty '
fi

NAME_PREFIX="$1"

# ensure that old containers are removed
docker-compose -p $NAME_PREFIX stop
docker-compose -p $NAME_PREFIX rm -f

# start application
docker-compose -p $NAME_PREFIX build --pull
docker-compose -p $NAME_PREFIX up -d --force-recreate

# up application
$WINPTY docker-compose -p $NAME_PREFIX start
