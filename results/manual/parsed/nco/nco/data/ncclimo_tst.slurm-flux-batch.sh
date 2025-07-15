#!/bin/bash
#FLUX: --job-name=ncclimo_tst
#FLUX: --queue=debug
#FLUX: -t=300
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export PATH='/global/homes/z/zender/bin_${NERSC_HOST}:${PATH}'

cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior
export OMP_NUM_THREADS=1
module use /global/project/projectdirs/acme/software/modulefiles/all
module load python/anaconda-2.7-acme
export PATH=/global/homes/z/zender/bin_${NERSC_HOST}:${PATH}
srun -n 1 -N 1 python ncclimo_tst.py
