#!/bin/bash
#SBATCH --job-name=cdropfin7
#SBATCH --output=slurm-%j-%x.out
#SBATCH --mail-user=aalag@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=2G
#SBATCH --time=01:00:00

module purge
module load anaconda3/2022.5
conda activate audit
wandb offline
epoch=50
I=0.7
experiment="COVIDx_dropout$I"
dataset="COVIDx"
for k in 0 10 20 30 40 50
do
    for fold in 0 1 2 3 4 5 6
    do
        echo k $k fold $fold
        python run_audit.py --k $k --fold $fold --audit EMA --epoch $epoch --cal_data $dataset --dataset $dataset --cal_size 10000 --expt $experiment --dropout $I
    done
done
