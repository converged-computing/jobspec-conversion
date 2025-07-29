#!/bin/bash
#SBATCH --job-name=xfbai-Conparsing
#SBATCH --output=logs/run-job%j.out
#SBATCH --error=logs/run-job%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --constraint=ntasks-per-node=96
#SBATCH --nodelist=wxhd11

hostname
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
module load Anaconda cuda-11.8 gcc-9.3.0
source activate py3.10torch2.0devel
cd $SLURM_SUBMIT_DIR
bash finetune_conparsing_clm_13B.sh
