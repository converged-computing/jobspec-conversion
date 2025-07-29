#!/bin/bash
#SBATCH --job-name=TestDDP_GPUBind_MPIDatloader
#SBATCH --output=Test-R-%j-%x.log
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:8
#SBATCH --mem=0
#SBATCH --time=01:00:00
#SBATCH --partition=alpha,alpha-interactive
#SBATCH --constraint=ntasks-per-node=24,fs_beegfs

module purge
ml modenv/hiera 
ml GCC/11.3.0
ml OpenMPI/4.1.4
ml imkl/2022.0.1
ml CUDA/11.7.0
ml cuDNN/8.4.1.50-CUDA-11.7.0
ml NCCL/2.12.12-CUDA-11.7.0
ml Python/3.9.6-bare
source venv
srun --distribution=plane=3 python3 -u MultiProcPerGPU_DPPMPI.py
