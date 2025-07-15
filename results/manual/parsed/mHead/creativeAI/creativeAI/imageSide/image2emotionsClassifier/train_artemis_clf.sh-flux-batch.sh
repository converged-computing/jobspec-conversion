#!/bin/bash
#FLUX: --job-name=creativeAI-image2emotionClassifier
#FLUX: -c=6
#FLUX: --queue=cuda
#FLUX: -t=86400
#FLUX: --priority=16

ml purge
ml nvidia/cudasdk/10.1
ml intel/python/3/2019.4.088
cd /home/mtesta/creativeAI/imageSide
python3 main.py
srun --partition=cuda --nodes=1 --tasks-per-node=1 --gres=gpu:1 --time=06:00:00 --pty /bin/bash
