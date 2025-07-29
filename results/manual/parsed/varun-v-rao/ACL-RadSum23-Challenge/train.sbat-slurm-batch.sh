#!/bin/bash
#SBATCH --job-name=bert2bert
#SBATCH --account=bioinf585w23_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=04:00:00
#SBATCH --partition=gpu

my_job_header
/bin/hostname
module purge
module load python/3.10.4
module load pytorch
!pip install transformers bert-extractive-summarizer datasets evaluate rouge_score sacrebleu git-python==1.0.3
python3 train_bert2bert.py
