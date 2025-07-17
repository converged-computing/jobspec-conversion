#!/bin/bash
#FLUX: --job-name=wf_datamagassim
#FLUX: -n=32
#FLUX: --exclusive
#FLUX: --queue=ncpum
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

module purge
module load aocc
module load aocl/3.0-6/fftw
module load python #for python3
module load openmpi/intel-19U5/4.1.1-ucx-1.10.1
module list
export OMP_NUM_THREADS=1
mpiexec -n $SLURM_NTASKS python3 ./workflow.py
