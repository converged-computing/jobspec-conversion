#!/bin/bash
#SBATCH --job-name=synergia2
#SBATCH --account=accelsim
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --time=00:30:00
#SBATCH --partition=wc_gpu
#SBATCH: --exclusive

module purge > /dev/null 2>&1
module load gcc/12.3.0
source /wclustre/accelsim/spack_013024/envs/synergia-devel3-gpu-p100-ompi.sh
mpirun -np 1 ./wrapper_ompi.sh 
