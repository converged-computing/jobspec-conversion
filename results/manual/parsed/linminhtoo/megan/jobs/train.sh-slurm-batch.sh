#!/bin/bash
#SBATCH --job-name=MEGAN_f10_pat4_stop8_maxn80
#SBATCH --output=logs/seed77777777_output_%x_%j.txt
#SBATCH --error=logs/seed77777777_error_%x_%j.txt
#SBATCH --mail-user=linmin001@e.ntu.edu.sg
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=9500
#SBATCH --time=1-06:00:00

source /cm/shared/engaging/anaconda/2018.12/etc/profile.d/conda.sh
source env_seed77777777.sh
module load gcc/8.3.0
python3 bin/train.py uspto_50k models/uspto_50k
