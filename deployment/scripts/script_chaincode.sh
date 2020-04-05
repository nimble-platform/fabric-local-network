#!/bin/bash

echo
echo " ____    _____      _      ____    _____ "
echo "/ ___|  |_   _|    / \    |  _ \  |_   _|"
echo "\___ \    | |     / _ \   | |_) |   | |  "
echo " ___) |   | |    / ___ \  |  _ <    | |  "
echo "|____/    |_|   /_/   \_\ |_| \_\   |_|  "
echo
echo "install and instantiate new chaincode script is running.."
echo
CHANNEL_NAME="$1"
CC_NAME="$2"
CC_SRC_PATH="$3"
INSTANTIATE_ARGS="$4"
CC_VERSION="$5"
DELAY="3"
LANGUAGE="golang"
TIMEOUT="10"
VERBOSE="false"

LANGUAGE=`echo "$LANGUAGE" | tr [:upper:] [:lower:]`
COUNTER=1
MAX_RETRY=10

echo "Channel name : "$CHANNEL_NAME
echo "Chaincode name : "$CC_NAME
echo "Chaincode source code path: " $CC_SRC_PATH
echo "Instantiate args: " $INSTANTIATE_ARGS
echo "Chaincode version: " $CC_VERSION

# import utils
. scripts/utils.sh


## Install chaincode on peer0.org1 and peer0.org2
echo "Installing chaincode on peer0.org1..."
installChaincode 0 1
echo "Installing chaincode on peer1.org1..."
installChaincode 1 1
echo "Install chaincode on peer0.org2..."
installChaincode 0 2
echo "Install chaincode on peer1.org2..."
installChaincode 1 2

# Instantiate chaincode on peer0.org1
echo "Instantiating chaincode on peer0.org2..."
instantiateChaincode 0 1
	

echo
echo "========= All GOOD, execution completed =========== "
echo

echo
echo " _____   _   _   ____   "
echo "| ____| | \ | | |  _ \  "
echo "|  _|   |  \| | | | | | "
echo "| |___  | |\  | | |_| | "
echo "|_____| |_| \_| |____/  "
echo

exit 0
