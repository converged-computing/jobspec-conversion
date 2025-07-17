#!/bin/bash
#FLUX: --job-name=apogee-run
#FLUX: -n=640
#FLUX: --queue=cca
#FLUX: -t=259200
#FLUX: --urgency=16

source ~/.bash_profile
init_conda
conda activate hq
echo $HQ_RUN
cd /mnt/ceph/users/apricewhelan/projects/hq/scripts
date
mpirun -n $SLURM_NTASKS python3 run_apogee.py --name $HQ_RUN --mpi -v
date
