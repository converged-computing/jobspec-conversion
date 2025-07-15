#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --urgency=16

module add Anaconda3/2020.11
conda activate /ceph/hpc/home/euqiamgl/.conda/envs/pyhpda
python $1 > $1.out
exit 0
