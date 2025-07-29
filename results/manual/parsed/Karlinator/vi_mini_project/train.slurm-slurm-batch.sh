#!/bin/bash
#SBATCH --job-name=vi-mini-project
#SBATCH --account=share-ie-idi
#SBATCH --output=out_train.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=250G
#SBATCH --time=08:00:00
#SBATCH --partition=GPUQ
#SBATCH --constraint=gpu40g|gpu80g|gpu32g

module load Python/3.10.8-GCCcore-12.2.0
source venv/bin/activate
python main.py train -e 100
