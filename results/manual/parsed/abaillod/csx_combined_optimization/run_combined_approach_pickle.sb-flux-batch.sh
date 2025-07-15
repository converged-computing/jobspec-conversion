#!/bin/bash
#FLUX: --job-name=CSX
#FLUX: -t=87839
#FLUX: --urgency=16

source ~/.bashrc
conda activate simsopt
module load gcc/10.2.0
module load openmpi/gcc/64/4.1.5a1
module load netcdf/gcc/64/gcc/64/4.7.4
module load lapack/gcc/64/3.9.0
module load hdf5p/1.10.7
module load netcdf-fortran/4.5.3 
module load intel-parallel-studio/2020
srun --mpi=pmix_v3 python combined_csx_optimization.py --pickle --input $1
