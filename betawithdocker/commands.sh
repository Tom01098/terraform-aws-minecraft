#!/bin/bash

sudo snap install docker && sudo docker run -d -it -p 25565:25565 -e EULA=TRUE itzg/minecraft-server