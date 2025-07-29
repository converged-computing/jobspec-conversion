#!/bin/bash
#SBATCH --job-name=CA_EX10_stream
#SBATCH --output=/home/hpc/rzku/hpcv651h/gitrepo/CA_computer_exercise/ex_10/ex10_stream.out
#SBATCH --error=/home/hpc/rzku/hpcv651h/gitrepo/CA_computer_exercise/ex_10/ex10_stream.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx3080:1
#SBATCH --time=02:00:00

set -x
set -v
module load cuda
srun ../bin/matmul_gpu > matmul_gpu.csv
touch ready
