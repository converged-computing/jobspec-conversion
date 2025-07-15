#!/bin/bash
#FLUX: --job-name=tart-lemur-3386
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load nvidia-hpc-sdk
module load gcc/8.3.0
python /scratch1/wenhuicu/brainseg/evaluation.py --name='BCE0.0001weighted_BCE2'
