#!/bin/bash
#SBATCH --job-name=GROMACS.GPU
#SBATCH --output=GROMACS.GPU.%j.out
#SBATCH --error=GROMACS.GPU.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:59:00
#SBATCH --partition=gpu

module load 2022
module load GROMACS/2021.6-foss-2022a-CUDA-11.7.0
PROJECT_DIR=/projects/0/energy-course
srun --ntasks=3 --cpus-per-task=6 gmx_mpi mdrun -s $PROJECT_DIR/GROMACS/hEGFRDimerSmallerPL_benchmark.tpr -nb gpu
