Git clone with:
```
$ git clone git@github.com:hxlaf/iroha_docker.git -b iroha_1.2.0
```
Build it with: 

```
$ docker-compose up -d
```
Enter the docker container with:
```
$docker exec -it containerid bash

```
Test with:
```
$irohad --config config.docker --genesis_block genesis.block --keypair_name node0
