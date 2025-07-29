#!/bin/bash
#SBATCH --job-name=test.omp
#SBATCH --account=project_465000485
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=00:10:00
#SBATCH --partition=eap
#SBATCH --constraint=ntasks-per-node=1

export LD_LIBRARY_PATH='/scratch/project_465000485/Clacc/llvm-project/install/lib:$LD_LIBRARY_PATH'

module load CrayEnv
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm/5.2.3
export LD_LIBRARY_PATH=/scratch/project_465000485/Clacc/llvm-project/install/lib:$LD_LIBRARY_PATH
time srun ./executable.omp.exe
