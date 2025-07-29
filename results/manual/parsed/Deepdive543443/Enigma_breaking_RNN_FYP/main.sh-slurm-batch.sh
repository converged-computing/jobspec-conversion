#!/bin/bash
#SBATCH --output=output.%j.test.out
#SBATCH --mail-user=qfeng10@sheffield.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=6G
#SBATCH --partition=gpu
#SBATCH --qos=gpu

module load Anaconda3/5.3.0
module load cuDNN/7.6.4.38-gcccuda-2019b
source activate torch
python main.py --PROGRESS_BAR=0 --USE_COMPILE=1 --LOG='tensorboard/16HEAD' --ATTN_HEAD=16
