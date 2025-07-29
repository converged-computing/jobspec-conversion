#!/bin/bash
#SBATCH --job-name=test-gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --time=00:10:00
#SBATCH --partition=GPU-small
#SBATCH --constraint=ntasks-per-node=7

source /etc/profile.d/modules.sh
module load singularity/2.6.0
module unload intel
module load mpi/gcc_openmpi
rm -f test-results-gpu.out
mpirun -n 1 singularity exec --nv software.simg python3 serial-gpu.py
