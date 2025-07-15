#!/bin/bash
#FLUX: --job-name=grated-animal-1086
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load nvidia-hpc-sdk
module load gcc/8.3.0
python /scratch1/wenhuicu/brainseg/evaluation.py --name='BCE0.0001weighted_BCE2'
