#! /bin/bash
#
# https://www.server-world.info/en/note?os=CentOS_7&p=tensorflow&f=1
#
docker build --rm=true --force-rm=true --tag koz/ml .

# docker build --rm=true --force-rm=true --tag koz/ml-gpu --file=Dockerfile-gpu .
