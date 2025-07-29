#!/bin/bash
#SBATCH --job-name=resnet50-mc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=04:50:00
#SBATCH --partition=gpu

module purge
module load Singularity
singularity exec --bind /nesi/project/uoa03709/work-dir/py-data:/var/inputdata --cleanenv --nv /nesi/project/uoa03709/containers/sif/smp-cv_0.2.0.sif python /var/inputdata/train_UPP_resnet50.py
