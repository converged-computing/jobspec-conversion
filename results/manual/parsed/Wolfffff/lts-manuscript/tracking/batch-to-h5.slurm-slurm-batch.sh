#!/bin/bash
#SBATCH --job-name=bat_inf
#SBATCH --output=logs/batch_inf_%A_%a.out
#SBATCH --error=logs/batch_inf_%A_%a.err
#SBATCH --mail-user=swwolf@princeton.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128G
#SBATCH --time=01:00:00
#SBATCH --array=1-190

module load conda
conda init bash
conda activate sleap_dev
TARGET_DIR="/Genomics/ayroleslab2/scott/long-timescale-behavior/data/organized_tracks/20220217-lts-cam1"
LIST="1through190-tracked.txt"
LINE_NUMBER=${SLURM_ARRAY_TASK_ID}
FILE=$(sed "${LINE_NUMBER}q;d" ${LIST})
OUTPUT_NAME=${FILE%.slp}
sleap-convert ${FILE} --format analysis
