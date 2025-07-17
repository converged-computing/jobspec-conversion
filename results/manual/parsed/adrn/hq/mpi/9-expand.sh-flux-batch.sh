#!/bin/bash
#FLUX: --job-name=apogee-expand
#FLUX: -N=4
#FLUX: --queue=cca
#FLUX: -t=43200
#FLUX: --urgency=16

source ~/.bash_profile
init_conda
cd /mnt/ceph/users/apricewhelan/projects/hq/scripts
conda activate hq
date
mpirun -n $SLURM_NTASKS python3 expand_samples.py --name $HQ_RUN -v --mpi
cd /mnt/ceph/users/apricewhelan/projects/hq/cache/$HQ_RUN
tar -czf samples.tar.gz samples/
date
