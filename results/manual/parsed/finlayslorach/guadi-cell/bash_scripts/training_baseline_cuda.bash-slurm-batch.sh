#!/bin/bash
#SBATCH --job-name=multilabel_model
#SBATCH --output=model_%A.out
#SBATCH --error=model_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a6000:1
#SBATCH --time=3-00:00:00

module purge 
module load anaconda3
source activate fastai
python /hpc/scratch/hdd2/fs541623/Cell_Tox_Assay_080421/FEATURE_EXTRACTION/ModelTest.py 
