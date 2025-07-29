#!/bin/bash
#SBATCH --account=vjgo8416-ms-img-pc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=0
#SBATCH --time=08:00:00
#SBATCH --qos=turing
#SBATCH --constraint=ntasks-per-node=1

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

source /path/to/environment/pyenv_affinity/bin/activate
module purge
module load baskerville
module load bask-apps/live
module load NCCL/2.12.12-GCCcore-11.3.0-CUDA-11.7.0
module load PyTorch/2.0.1-foss-2022a-CUDA-11.7.0
module load torchvision/0.15.2-foss-2022a-CUDA-11.7.0
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun python /path/to/affinity-vae/run.py --config_file path/to/avae-config_file --new_out
