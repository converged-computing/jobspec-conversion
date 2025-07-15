#!/bin/bash
#FLUX: --job-name=psycho-lamp-1834
#FLUX: -n=128
#FLUX: -t=14400
#FLUX: --urgency=16

export I_MPI_FABRICS='shm'
export OMP_NUM_THREADS='1'

module purge
module load intel
module load intel-mkl
module list
export I_MPI_FABRICS=shm
export OMP_NUM_THREADS=1
conda activate diffusion
python myhops_2023.py 600;
