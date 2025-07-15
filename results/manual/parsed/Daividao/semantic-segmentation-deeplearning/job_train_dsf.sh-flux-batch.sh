#!/bin/bash
#FLUX: --job-name=2dunet
#FLUX: -c=4
#FLUX: --queue=savio2_1080ti
#FLUX: -t=259200
#FLUX: --priority=16

module load python
module load tensorflow/1.10.0-py36-pip-gpu
module load cuda
python /global/scratch/dt111997/project/train_dsf.py
