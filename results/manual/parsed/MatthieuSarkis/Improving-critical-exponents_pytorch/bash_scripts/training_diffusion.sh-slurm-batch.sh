#!/bin/bash
#SBATCH --job-name=diffusion_ising
#SBATCH --output=OUTPUT_training_ising.out
#SBATCH --error=ERROR_training_ising.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=8

export OMP_NUM_THREADS='1'

ulimit -s unlimited
export OMP_NUM_THREADS=1
module load lang/Python/3.8.6-GCCcore-10.2.0
. /home/users/msarkis/git_repositories/Improving-critical-exponents_pytorch/.env/bin/activate
module load toolchain/intel
python src/denoising-diffusion-pytorch/train.py
