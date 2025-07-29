#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=160G
#SBATCH --time=10:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='1'

module load 2022
module load CMake/3.23.1-GCCcore-11.3.0
module load OpenMPI/4.1.4-GCC-11.3.0
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
cd ../out/LinRel/bin
srun ./lostsales_paper_results
