#!/bin/bash
#FLUX: --job-name=loopy-destiny-0907
#FLUX: --urgency=16

export which='sim'
export bricks_fn='${CSCRATCH}/obiwan_out/elg_dr5_coadds/partially_done_bricks.txt'
export KMP_AFFINITY='disabled'
export MPICH_GNI_FORK_MODE='FULLCOPY'
export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='1'

export which=sim
let tasks=32*${SLURM_JOB_NUM_NODES}
export bricks_fn=${CSCRATCH}/obiwan_out/elg_dr5_coadds/partially_done_bricks.txt
source $CSCRATCH/obiwan_code/obiwan/bin/run_atnersc/bashrc_desiconda
export KMP_AFFINITY=disabled
export MPICH_GNI_FORK_MODE=FULLCOPY
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
srun -n ${tasks} -c 1 \
    python $CSCRATCH/obiwan_code/obiwan/py/obiwan/tensorflow/create_training.py \
    --which ${which} --bricks_fn ${bricks_fn} --nproc ${tasks}
