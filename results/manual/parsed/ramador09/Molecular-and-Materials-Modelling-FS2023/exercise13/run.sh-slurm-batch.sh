#!/bin/bash
#SBATCH --job-name=mol. dyn.
#SBATCH --account=crs01
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=12,gpu

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK:-1}'
export CRAY_CUDA_MPS='1'

module load daint-gpu
module load CP2K
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1}
export CRAY_CUDA_MPS=1
ulimit -s unlimited
srun -n 12 cp2k.popt -i md.inp -o md.out
