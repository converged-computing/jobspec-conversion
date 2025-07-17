#!/bin/bash
#FLUX: --job-name=muffled-fudge-4234
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

. /home/tscherli/.bash_profile
echo "Starting Docker Image"
pwd
docker ps
nvidia-docker ps
set -x
nvidia-docker run -v /data/datasets:/data/datasets -v /home/tscherli:/home/tscherli tscherli/alphatraining python3 /data/datasets/tscherli/task2/train/basic3.py &
wait
echo "Done!"
