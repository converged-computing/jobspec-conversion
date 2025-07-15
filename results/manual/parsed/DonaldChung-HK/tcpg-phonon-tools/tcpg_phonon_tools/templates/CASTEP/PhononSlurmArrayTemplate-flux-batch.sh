#!/bin/bash
#FLUX: --job-name=25_diiodothiophene_CASTEP_opt
#FLUX: -N=6
#FLUX: --exclusive
#FLUX: -t=36000
#FLUX: --priority=16

module purge
module load AMDmodules
module load Python/3.10.4-GCCcore-11.3.0
module load CASTEP/21.1.1-iomkl-2021a
module list
mpirun castep.mpi CuSO4_5H2O
