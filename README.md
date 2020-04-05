# fabric-local

this repository runs local network of fabric, with two orgs and two peers in each org.
the used images and binaries are of version v1.4.3 of fabric

before starting anything, there is a need to get all pre-requisites.
for this, you will need to run the script -   
`deployment/bootstrap.sh 1.4.3 -s -b`

in order to start local network run -   
`deployment/run_network_local.sh up`

in order to create a new channel run -   
`deployment/create_new_channel.sh -c CHANNEL_NAME`

in order to deploy (install & instantiate) new chaincdoe there are several steps to do:
1. put a new directory containing the chaincode code inside the dir `chaincode`
2. the path to be used in the next command is `github.com/chaincode/`chaincode dir name as created in step (1)
3. run `deployment/deploy_chaincode.sh -c CHANNEL_NAME -n CC_NAME -p github.com/chaincode/CC_DIR -i INIT_ARGS -v 1.0` (-i is optional)

inorder to stop all run -   
`deployment/run_network_local.sh down`
