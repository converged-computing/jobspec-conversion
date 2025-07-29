#!/bin/bash
#SBATCH --job-name=processing
#SBATCH --account=fc_deepmusic
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:02:00
#SBATCH --partition=savio
#SBATCH --constraint=ntasks-per-node=1

module load ml/tensorflow/2.5.0-py37 libsndfile
python export_job.sh
