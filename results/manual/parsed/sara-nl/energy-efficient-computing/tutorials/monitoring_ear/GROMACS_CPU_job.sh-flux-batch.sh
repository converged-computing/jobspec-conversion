#!/bin/bash
#FLUX: --job-name=GROMACS.CPU
#FLUX: -n=128
#FLUX: --exclusive
#FLUX: --priority=16

module load 2022
module load GROMACS/2021.6-foss-2022a-CUDA-11.7.0
PROJECT_DIR=/projects/0/energy-course
srun --ntasks=128 --cpus-per-task=1 gmx_mpi mdrun -s $PROJECT_DIR/GROMACS/hEGFRDimerSmallerPL_benchmark.tpr
