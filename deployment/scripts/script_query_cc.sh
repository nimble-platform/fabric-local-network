#!/bin/bash

CHANNEL_NAME="$1"
CC_NAME="$2"
ARGS="$3"

DELAY="1"
TIMEOUT="10"
VERBOSE="false"
COUNTER=1
MAX_RETRY=10

echo "Channel name : "$CHANNEL_NAME
echo "Chaincode name : "$CC_NAME
echo "args: " $ARGS

# import utils
. scripts/utils.sh

chaincodeQuery 0 1
	
exit 0
