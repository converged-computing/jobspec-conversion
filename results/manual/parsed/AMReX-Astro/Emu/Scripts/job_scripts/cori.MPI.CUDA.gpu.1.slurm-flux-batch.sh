#!/bin/bash
#FLUX: --job-name=dinosaur-eagle-2054
#FLUX: -c=10
#FLUX: -t=900
#FLUX: --priority=16

export OMP_PLACES='cores'
export OMP_PROC_BIND='true'
export OMP_NUM_THREADS='5'

cd $SLURM_SUBMIT_DIR
export OMP_PLACES=cores
export OMP_PROC_BIND=true
export OMP_NUM_THREADS=5
srun --cpu_bind=cores ./main3d.gnu.DEBUG.TPROF.MPI.CUDA.ex inputs_bipolar_test
