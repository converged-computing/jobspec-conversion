#!/bin/bash
#SBATCH --job-name=tensorflow-mnist-docker
#SBATCH --output=tensorflow-mnist-docker.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00

docker run -td --gpus all -v /home/user00:/home/user00 --rm --ipc=host --net=host --name tensorflow-user00 tensorflow-user00
docker exec -t -u user00 -w $HOME/tensorflow tensorflow-user00 python3 download_mnist.py
docker exec -t -u user00 -w $HOME/tensorflow tensorflow-user00 python3 mnist_training2.py
docker stop tensorflow-user00
