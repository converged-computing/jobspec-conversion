#!/bin/bash
#FLUX: --job-name=fugly-pedo-0458
#FLUX: --urgency=16

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/home/apricewhelan/software/lib/
cd /mnt/ceph/users/apricewhelan/projects/dr2-lmc-cluster/scripts
module load gcc openmpi2
date
python run_isochrones_sample.py --index=$SLURM_ARRAY_TASK_ID
date
