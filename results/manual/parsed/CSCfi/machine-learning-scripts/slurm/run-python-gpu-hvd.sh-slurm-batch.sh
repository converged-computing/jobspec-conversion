#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:k80:4
#SBATCH --mem-per-cpu=32G
#SBATCH --time=01:00:00
#SBATCH --partition=gpu

module load python-env/3.6.3-ml
module list
set -xv
mpirun -np 4 -bind-to none -map-by slot \
    -x NCCL_DEBUG=INFO -x LD_LIBRARY_PATH -x PATH \
    -mca pml ob1 -mca btl ^openib -oversubscribe \
    python3.6 $*
