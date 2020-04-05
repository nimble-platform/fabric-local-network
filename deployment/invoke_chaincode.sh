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
  echo "  invoke_chaincode.sh [-c <channel name>] [-n <chaincode nane>] [-a <args>]"
  echo "  invoke_chaincode.sh -h (print this message)"
  echo
}

function run() {
  RES="$(docker exec cli scripts/script_invoke_cc.sh $CHANNEL_NAME $CC_NAME $ARGS)"
  if [ $? -ne 0 ]; then
    RES="$(echo $RES | awk -Fmessage: '{print $2}' | awk -F!!!!!!!!!!!!!!! '{print $1}')"
    echo $RES
    exit 1
  fi
  RES="$(echo $RES | awk -Fpayload: '{print $2}')"
  RES=${RES%%=====================*}
  echo $RES
}

CHANNEL_NAME=""
CC_NAME=""
ARGS='[]'

while getopts "h?c:n:a:" opt; do
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
  a)
    ARGS=$OPTARG
    ;;
  esac
done

#Create the network using docker compose
run
