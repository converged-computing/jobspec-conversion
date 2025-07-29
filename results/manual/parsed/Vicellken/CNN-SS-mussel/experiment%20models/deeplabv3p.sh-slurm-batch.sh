#!/bin/bash
#SBATCH --job-name=deeplabv3p
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=YOUR_EMAIL
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=6-00:00:00
#SBATCH --qos=gpu
#SBATCH --exclude=SPG-1-[1-4]

export CUDA_VISIBLE_DEVICES='0,1,2,3 # use 4 GPUs'
export FLAGS_sync_nccl_allreduce='1 # use nccl to do allreduce'
export FLAGS_enable_parallel_graph='1 # enable parallel graph mode'

'''
Operating System: CentOS 8 (x86-64)
HPC software stack: OpenHPC
Job Scheduler: SLURM
Parallel computing framework: PaddlePaddle
Change the following variables to fit your own environment
'''
source ~/.bashrc
conda activate paddle_x3.9  # specify your conda environment name
module load cuda            # load cuda module on demand
export CUDA_VISIBLE_DEVICES=0,1,2,3 # use 4 GPUs
'''
export FLAGS_sync_nccl_allreduce=1 # use nccl to do allreduce
export FLAGS_enable_parallel_graph=1 # enable parallel graph mode
'''
python -m paddle.distributed.launch --log_dir=output_deeplabv3p deeplabv3p.py
