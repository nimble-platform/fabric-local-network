#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# prepending $PWD/../bin to PATH to ensure we are picking up the correct binaries
# this may be commented out to resolve installed version of tools if desired

cd "$(dirname "$0")"

export PATH=${PWD}/../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=${PWD}
export VERBOSE=false

# Print the usage message
function printHelp() {
  echo "Usage: "
  echo "  deploy_chaincode.sh [-c <channel name>] [-n <chaincode nane>] [-p <cc source path>] [-i <instantiate args>] [-v <chaincode version>]"
  echo "  deploy_chaincode.sh -h (print this message)"
  echo
}

function run() {
  docker exec cli scripts/script_chaincode.sh $CHANNEL_NAME $CC_NAME $CC_SRC_PATH $INSTANTIATE_ARGS $CC_VERSION
  if [ $? -ne 0 ]; then
    echo "ERROR !!!! Test failed"
    exit 1
  fi
}

CHANNEL_NAME=""
CC_NAME=""
CC_SRC_PATH=""
INSTANTIATE_ARGS='["init"]'
CC_VERSION=""

while getopts "h?c:n:p:i:v:" opt; do
  case "$opt" in
  h | \?)
    printHelp
    exit 0
    ;;
  c)
    CHANNEL_NAME=$OPTARG
    ;;
  n)
    CC_NAME=$OPTARG
    ;;
  p)
    CC_SRC_PATH=$OPTARG
    ;;
  i) # concat each of the arguments, while adding double quotes to each
    INSTANTIATE_ARGS='["init"'
    cc_args=$(echo ${OPTARG} | tr "," "\n")
    for arg in $cc_args
    do
      INSTANTIATE_ARGS=$INSTANTIATE_ARGS',"'${arg}'"'
    done
    INSTANTIATE_ARGS=$INSTANTIATE_ARGS']'
    ;;
  v)
    CC_VERSION=$OPTARG
    ;;
  esac
done

#Create the network using docker compose
run
