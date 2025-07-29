#!/bin/bash
#SBATCH --account=courses
#SBATCH --output=prog.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=500M
#SBATCH --time=00:05:00
#SBATCH --partition=courses-gpu
#SBATCH --constraint=ntasks-per-node=2

export OMPI_MCA_opal_warn_on_missing_libcuda='0'

module purge
export OMPI_MCA_opal_warn_on_missing_libcuda=0
module load gcc/11.3.0 cmake/3.26.3 openmpi/4.1.5
time srun ../build/quicksort-distributed-gpu
