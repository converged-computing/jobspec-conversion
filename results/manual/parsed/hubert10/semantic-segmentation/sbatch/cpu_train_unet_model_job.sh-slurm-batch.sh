#!/bin/bash
#SBATCH --job-name=cpu_job_train_unet_model
#SBATCH --output=logs/training_unet_model%j.out
#SBATCH --mail-user=h.kanyamahanga@cgiar.org
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=1000gb
#SBATCH --time=08:00:00

pwd; hostname; date
module load tensorflow/2.4.1
python model_training/training_unet_model.py
date
