#!/bin/bash
#SBATCH --job-name=tensorflow-mnist-docker
#SBATCH --output=tensorflow-mnist-docker.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00

docker run -td --gpus all -v /home/__xUSERx__:/home/__xUSERx__ --rm --ipc=host --net=host --name tensorflow-__xUSERx__ tensorflow-__xUSERx__
docker exec -t -u __xUSERx__ -w $HOME/__xWORK_DIRx__ tensorflow-__xUSERx__ python3 download_mnist.py
docker exec -t -u __xUSERx__ -w $HOME/__xWORK_DIRx__ tensorflow-__xUSERx__ python3 mnist_training.py
docker stop tensorflow-__xUSERx__
