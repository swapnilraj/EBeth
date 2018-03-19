# EBeth

Uses truffle to compile smart contracts and to migrate `BetManager.sol` to the network.

## Pre-requisites:
* truffle
* geth

## How to compile?
Contracts can be compiled by running the following command:

```
truffle compile
```

The binary will be located in `/build/contracts/`

## How to migrate?
In order to migrate to a locally run network, there is need to start a geth node. Migration can be done using:

```
truffle migrate --network development
```

However for migrating to the Ropsten network, a geth node must be run on the computer. This can be done using:
```
geth --testnet --rpc --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --syncmode "light" --rpccorsdomain '*' --rpcaddr 0.0.0.0 --rpcport 8545 --cache 8192
```
_Note:  It might take a while to find a peer since we are using the Ropsten test network with a light geth node._

The first account managed by the geth client must be unlocked to allow transactions to be sent. Firsly the geth javascript console must be started using:

```
geth attach http://0.0.0.0:8545
```

Unlock the account using:

```
personal.unlockAccount(eth.accounts[0],"password",0)
```

If an account has not been added to the geth client, it can be done as so:

```
personal.importRawKey("private key","password")
```

_Other useful commands for the javascript console can be found [here](https://github.com/ethereum/go-ethereum/wiki/Management-APIs)_

Migration to the Ropsten test network can be done using:
```
truffle migrate --network ropsten
```

__It is important to note the deployed address of `BetManager.sol` since the Daemon and Frontend rely on that contract to manage all the Betting events.__
