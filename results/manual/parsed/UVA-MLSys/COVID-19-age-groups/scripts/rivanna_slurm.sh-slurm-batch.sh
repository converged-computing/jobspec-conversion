#!/bin/bash
#SBATCH --job-name=Crossformer_train_total
#SBATCH --account=bii_dsc_community
#SBATCH --output=scripts/outputs/Crossformer_train_total.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=32GB
#SBATCH --time=12:00:00
#SBATCH --partition=gpu

source /etc/profile.d/modules.sh
source ~/.bashrc
module load singularity
singularity run --nv timeseries.sif python run.py --data_path Total.csv --model Crossformer
