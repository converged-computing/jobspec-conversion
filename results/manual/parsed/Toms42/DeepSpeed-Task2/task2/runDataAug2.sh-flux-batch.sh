#!/bin/bash
#FLUX: --job-name=crunchy-omelette-0618
#FLUX: --urgency=16

. /home/tscherli/.bash_profile
echo "Starting Docker Image"
pwd
docker ps
nvidia-docker ps
set -x
nvidia-docker run -v /data/datasets:/data/datasets -v /home/tscherli:/home/tscherli tscherli/alphatraining python3 /data/datasets/tscherli/task2/data_aug/augment-less.py
wait
echo "Done!"
