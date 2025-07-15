#!/bin/bash
#FLUX: --job-name=outstanding-pot-5575
#FLUX: -N=2
#FLUX: -c=10
#FLUX: -t=900
#FLUX: --urgency=16

export OMP_PLACES='cores'
export OMP_PROC_BIND='true'
export OMP_NUM_THREADS='5'

cd $SLURM_SUBMIT_DIR
export OMP_PLACES=cores
export OMP_PROC_BIND=true
export OMP_NUM_THREADS=5
srun --cpu_bind=cores ./Castro3d.gnu.TPROF.MPI.CUDA.ex inputs.3d.sph.testsuite
