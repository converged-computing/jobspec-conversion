#!/bin/bash
#SBATCH --job-name=finetunemocounet
#SBATCH --output=/home/codee/scratch/sourcecode/cem-dataset/evaluation/pretrain_500k_test_%j_%N.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=128000M
#SBATCH --time=00:40:00
#SBATCH --constraint=ntasks-per-node=4

source /home/codee/miniconda3/etc/profile.d/conda.sh
conda activate base
log_dir="/home/codee/scratch/sourcecode/cem-dataset/evaluation/finetunesave"
echo log_dir : `pwd`/$log_dir
mkdir -p `pwd`/$log_dir
echo "$SLURM_NODEID Launching python script"
/home/codee/miniconda3/bin/python /home/codee/scratch/sourcecode/cem-dataset/evaluation/finetune.py > $log_dir/mocofinetune1.8
echo "finetune finished"
