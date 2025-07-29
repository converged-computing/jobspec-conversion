#!/bin/bash
#SBATCH --job-name=mlm_task
#SBATCH --output=./mlm-task-%j.out
#SBATCH --error=./mlm-task-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=80
#SBATCH --gres=gpu:8
#SBATCH --mem=5120
#SBATCH --time=1-17:40:00
#SBATCH --partition=learnfair
#SBATCH --constraint=ntasks-per-node=1

module purge
module load cuda/9.2
module load cudnn/v7.3-cuda.9.2
module load NCCL/2.2.13-1-cuda.9.2
source activate /private/home/zhangguanheng/anaconda3/envs/slurm_envir
srun --label --ntasks-per-node=1 --time=4000 --mem-per-cpu=5120 --gres=gpu:8 --cpus-per-task 80 --nodes=1 --pty python distributed_mlm_task.py --world_size 8 --parallel DDP --seed 5431916812 --epochs 100 --emsize 768 --nhid 3072  --nlayers 12 --nhead 12 --save-vocab squad_30k_vocab_cls_sep.pt --dataset EnWik9 --lr 6  --bptt 128  --batch_size 56 --clip 0.1 --log-interval 600 
