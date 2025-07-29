#!/bin/bash
#SBATCH --job-name=CA_EX9_stream
#SBATCH --output=/home/hpc/rzku/hpcv720h/ex_09/ex09_stream.out
#SBATCH --error=/home/hpc/rzku/hpcv720h/ex_09/ex09_stream.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx3080:1
#SBATCH --time=02:00:00

set -x
set -v
module load cuda
srun ../bin/stream_gpu >jacobi_100ms.csv
touch ready
