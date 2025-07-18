#!/bin/bash
#FLUX: --job-name=tensorflow-mnist-docker
#FLUX: -t=600
#FLUX: --urgency=16

docker run -td --gpus all -v /home/user00:/home/user00 --rm --ipc=host --net=host --name tensorflow-user00 tensorflow-user00
docker exec -t -u user00 -w $HOME/tensorflow tensorflow-user00 python3 download_mnist.py
docker exec -t -u user00 -w $HOME/tensorflow tensorflow-user00 python3 mnist_training.py
docker stop tensorflow-user00
