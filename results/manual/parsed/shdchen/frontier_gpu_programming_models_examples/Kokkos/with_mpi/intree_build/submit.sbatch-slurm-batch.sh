#!/bin/bash
#SBATCH --account=stf007uanofn
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'
export OMP_NUM_THREADS='4'

module purge
module load DefApps
module load PrgEnv-cray
module load rocm/5.1.0
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export OMP_NUM_THREADS=4
srun -N1 -n4 -c4 --gpus-per-task=1 --gpu-bind=closest ./cmake_build_dir/kokkos_example
