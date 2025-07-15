#!/bin/bash
#FLUX: --job-name=faux-toaster-3519
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
