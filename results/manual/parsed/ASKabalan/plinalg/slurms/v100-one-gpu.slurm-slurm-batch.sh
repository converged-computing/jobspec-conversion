#!/bin/bash
#SBATCH --job-name=V100-One-GPU-host
#SBATCH --account=nih@v100
#SBATCH --output=v100-one-GPU.out
#SBATCH --error=v100-one-GPU.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=00:04:00
#SBATCH --qos=qos_gpu-dev
#SBATCH --constraint=v100-16g,ntasks-per-node=1

export MODULEPATH='$NVHPC/modulefiles:$MODULEPATH'

module purge
module load python/3.10.4
source venv/bin/activate
module load cuda/11.8.0  cudnn/8.9.7.29-cuda cmake nvidia-compilers/23.9
export MODULEPATH=$NVHPC/modulefiles:$MODULEPATH
module load nvhpc-hpcx-cuda11/23.9
set -x
srun python -m pytest $1
