#!/bin/bash
#FLUX: --job-name=gloopy-signal-9084
#FLUX: --urgency=16

source ~/.bash_profile
init_conda
conda activate hq
echo $HQ_RUN
cd /mnt/ceph/users/apricewhelan/projects/hq/scripts
date
mpirun -n $SLURM_NTASKS python3 run_apogee.py --name $HQ_RUN --mpi -v
date
