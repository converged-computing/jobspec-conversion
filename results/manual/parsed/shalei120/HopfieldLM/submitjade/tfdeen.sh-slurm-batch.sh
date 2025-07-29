#!/bin/bash
#SBATCH --job-name=MT
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

module load cuda/9.2
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
echo $PWD
python3 main_mt.py -m transformer -b 64  -d DE_EN -g 0 -layer 6 -emb 512  >slurm-Tfseq2seq-$SLURM_JOB_ID.out
