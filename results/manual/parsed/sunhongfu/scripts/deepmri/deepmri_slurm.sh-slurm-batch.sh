#!/bin/bash
#SBATCH --job-name=xuanyu_test_tensor_gpu
#SBATCH --output=tensor_out.txt
#SBATCH --error=tensor_error.txt
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla:2
#SBATCH --mem-per-cpu=50000

module load cuda/9.2.148.1
module load gnu7
module load mvapich2
module load anaconda/3.6
module load pmix
srun -n2 python3.6 train.py --patch_height=48 --patch_width=48 --patch_depth=48 --data_path /scratch/itee/uqxuanyu/Dataset
