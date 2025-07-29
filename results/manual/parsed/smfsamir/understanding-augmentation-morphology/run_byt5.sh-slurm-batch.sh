#!/bin/bash
#SBATCH --account=rrg-mageed
#SBATCH --output=/scratch/fsamir8/augmentation_subset_select/byt5_train_all.out
#SBATCH --error=/scratch/fsamir8/augmentation_subset_select/byt5_train_all.error
#SBATCH --mail-user=fsamir@mail.ubc.ca
#SBATCH --mail-type=END,FAIL,INVALID_DEPEND
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=v100l:4
#SBATCH --mem=20G
#SBATCH --time=10:00:00

module load gcc/9.3.0 arrow python scipy-stack
python main_byt5.py train-model 
