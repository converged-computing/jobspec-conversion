#!/bin/bash
#SBATCH --job-name=dataset_gen
#SBATCH --output=./cluster/dataset_gen.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00

module load anaconda3
source activate sbi
echo 'start generating dataset'
python3 ./src/data_generator/dataset_for_training.py
echo 'finished simulation'
squeue -u $USER
scancel --user=wehe
squeue -u $USER
squeue -u $USER
