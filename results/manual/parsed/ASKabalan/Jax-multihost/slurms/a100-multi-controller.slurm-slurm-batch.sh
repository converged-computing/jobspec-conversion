#!/bin/bash
#SBATCH --job-name=A100-Multi-host
#SBATCH --account=tkc@a100
#SBATCH --output=a100-multi.out
#SBATCH --error=a100-multi.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=8

module purge
module load python/3.10.4
source venv/bin/activate
module load cuda/11.8.0  cmake cudnn/8.9.7.29-cuda nvidia-compilers/23.9 openmpi/4.1.5-cuda
set -x
srun python $1
