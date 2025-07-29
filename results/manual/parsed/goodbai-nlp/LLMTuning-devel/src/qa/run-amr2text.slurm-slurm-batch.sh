#!/bin/bash
#SBATCH --job-name=xfbai-QA
#SBATCH --output=logs/run-job%j.out
#SBATCH --error=logs/run-job%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --constraint=ntasks-per-node=96
#SBATCH --nodelist=wxhd09

hostname
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
module load Anaconda cuda-11.8 gcc-9.3.0
source /data/anaconda3/bin/activate
conda activate py3.10torch2.0devel
cd $SLURM_SUBMIT_DIR
bash finetune_qa_clm_lora.sh
