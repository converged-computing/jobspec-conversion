#!/bin/bash
#SBATCH --job-name=GROMACS.CPU
#SBATCH --output=GROMACS.CPU.%j.out
#SBATCH --error=GROMACS.CPU.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=00:59:00
#SBATCH --exclusive

module load 2022
module load GROMACS/2021.6-foss-2022a-CUDA-11.7.0
PROJECT_DIR=/projects/0/energy-course
srun --ntasks=128 --cpus-per-task=1 gmx_mpi mdrun -s $PROJECT_DIR/GROMACS/hEGFRDimerSmallerPL_benchmark.tpr
