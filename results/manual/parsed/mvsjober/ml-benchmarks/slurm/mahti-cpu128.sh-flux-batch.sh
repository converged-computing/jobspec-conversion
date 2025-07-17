#!/bin/bash
#FLUX: --job-name=creamy-parrot-7835
#FLUX: -c=128
#FLUX: --queue=test
#FLUX: -t=60
#FLUX: --urgency=16

export OMP_NUM_THREADS='128'
export MKL_NUM_THREADS='128'
export OMP_SCHEDULE='STATIC'
export OMP_PROC_BIND='CLOSE'
export GOMP_CPU_AFFINITY='0-127'

export OMP_NUM_THREADS=128
export MKL_NUM_THREADS=128
export OMP_SCHEDULE=STATIC
export OMP_PROC_BIND=CLOSE
export GOMP_CPU_AFFINITY="0-127"
cd $SLURM_SUBMIT_DIR
source slurm/common.sh
