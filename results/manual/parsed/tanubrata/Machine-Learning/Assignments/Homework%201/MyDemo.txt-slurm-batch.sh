#!/bin/bash
#SBATCH --output=foo.txt
#SBATCH --mail-user=foo@bar.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=70GB
#SBATCH --time=5-13:00:00
#SBATCH --partition=gpu8_long
#SBATCH --constraint=ntasks-per-node=1

module load matlab/
module load anaconda3/cpu/5.2.0
module load cuda90/toolkit/9.1.176
module load cuda90/fft/9.1.176
cd /scratch/td2201/
python ml_is_good.py
