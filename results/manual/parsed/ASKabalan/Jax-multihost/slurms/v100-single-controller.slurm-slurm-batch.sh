#!/bin/bash
#SBATCH --job-name=V100-Single-host
#SBATCH --account=nih@v100
#SBATCH --output=v100-single.out
#SBATCH --error=v100-single.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4
#SBATCH --time=00:10:00
#SBATCH --constraint=v100-16g,ntasks-per-node=1

module purge
module load python/3.10.4
source venv/bin/activate
module load cuda/11.8.0  cmake cudnn/8.9.7.29-cuda nvidia-compilers/23.9 openmpi/4.1.5-cuda
set -x
srun python $1
