#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100:4
#SBATCH --mem=350GB
#SBATCH --time=1-00:00:00
#SBATCH --partition=bii-gpu

module purge
module load anaconda/2020.11-py3.8
module load singularity tensorflow/2.10.0
singularity run --nv $CONTAINERDIR/tensorflow-2.10.0.sif binary_ann_with_smote.py
