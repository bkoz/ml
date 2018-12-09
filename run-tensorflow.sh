#!/bin/bash
#
# tensorflow
# https://hub.docker.com/r/gw000/keras-full
# https://github.com/gw0/docker-keras-full
# Docker base device size needs to be increased beyond 10GB or container will fail start up. 
# https://access.redhat.com/solutions/2914731

TENSOR_DIR=/home/bkozdemb/src/tensorflow
# rm -rf /pv/tensorflow
# mkdir -p /pv/tensorflow
# chmod -R 777 /pv/tensorflow
chcon -R system_u:object_r:svirt_sandbox_file_t:s0 $TENSOR_DIR

NOTEBOOKS="-v ${TENSOR_DIR}:/opt/app-root/notebooks"
CERTS="-v /pv/certs:/certs"
PORTS="-p 9000:8888 -p 9001:6006"

docker run -d --name ml --rm ${PORTS} ${NOTEBOOKS} ${CERTS} koz/ml notebooks/run-jupyter.sh 
