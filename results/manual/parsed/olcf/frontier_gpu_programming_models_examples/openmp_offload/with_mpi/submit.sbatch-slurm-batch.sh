#!/bin/bash
#SBATCH --account=stf007uanofn
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:35:00

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'
export OMP_NUM_THREADS='4'

module load PrgEnv-cray
module load amd-mixed
module load craype-accel-amd-gfx90a
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
export OMP_NUM_THREADS=4
srun -N2 -n4 -c4 --gpus-per-task=4 --gpu-bind=closest $ROCPROF ./cmake_build_dir/jacobi 10000 100 #10000 100 
