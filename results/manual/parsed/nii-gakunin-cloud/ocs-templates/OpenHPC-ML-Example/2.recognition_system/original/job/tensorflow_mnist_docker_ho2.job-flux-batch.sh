#!/bin/bash
#FLUX: --job-name=tensorflow-mnist-docker
#FLUX: -t=600
#FLUX: --urgency=16

docker run -td --gpus all -v /home/__xUSERx__:/home/__xUSERx__ --rm --ipc=host --net=host --name tensorflow-__xUSERx__ tensorflow-__xUSERx__
docker exec -t -u __xUSERx__ -w $HOME/__xWORK_DIRx__ tensorflow-__xUSERx__ python3 download_mnist.py
docker exec -t -u __xUSERx__ -w $HOME/__xWORK_DIRx__ tensorflow-__xUSERx__ python3 mnist_training2.py
docker stop tensorflow-__xUSERx__
