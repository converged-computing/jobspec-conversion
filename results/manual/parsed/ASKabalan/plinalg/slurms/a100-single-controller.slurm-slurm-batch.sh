#!/bin/bash
#SBATCH --job-name=A100-Single-host
#SBATCH --account=tkc@a100
#SBATCH --output=a100-single.out
#SBATCH --error=a100-single.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --time=00:04:00
#SBATCH --qos=qos_gpu-dev
#SBATCH --constraint=ntasks-per-node=1

export MODULEPATH='$NVHPC/modulefiles:$MODULEPATH'

module purge
module load python/3.10.4
source venv/bin/activate
module load cuda/11.8.0  cudnn/8.9.7.29-cuda cmake nvidia-compilers/23.9
export MODULEPATH=$NVHPC/modulefiles:$MODULEPATH
module load nvhpc-hpcx-cuda11/23.9
set -x
srun python $1
