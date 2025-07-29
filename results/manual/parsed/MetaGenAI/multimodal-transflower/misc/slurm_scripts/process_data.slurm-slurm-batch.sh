#!/bin/bash
#SBATCH --job-name=process_data
#SBATCH --account=imi@cpu
#SBATCH --nodes=1
#SBATCH --ntasks=160
#SBATCH --cpus-per-task=2
#SBATCH --time=20:00:00
#SBATCH --qos=qos_cpu-t3

export ROOT_FOLDER='/gpfswork/rech/imi/usc19dv/captionRLenv/'
export DATA_FOLDER='/gpfsscratch/rech/imi/usc19dv/data/UR5/'
export PROCESSED_DATA_FOLDER='/gpfsscratch/rech/imi/usc19dv/data/UR5_processed/'
export ROOT_DIR_MODEL='/gpfswork/rech/imi/usc19dv/mt-lightning/'
export PRETRAINED_FOLDER='/gpfswork/rech/imi/usc19dv/mt-lightning/training/experiments/'

module purge
module load pytorch-gpu/py3/1.8.1
export ROOT_FOLDER=/gpfswork/rech/imi/usc19dv/captionRLenv/
export DATA_FOLDER=/gpfsscratch/rech/imi/usc19dv/data/UR5/
export PROCESSED_DATA_FOLDER=/gpfsscratch/rech/imi/usc19dv/data/UR5_processed/
export ROOT_DIR_MODEL=/gpfswork/rech/imi/usc19dv/mt-lightning/
export PRETRAINED_FOLDER=/gpfswork/rech/imi/usc19dv/mt-lightning/training/experiments/
srun --wait=0 -n 160 ./feature_extraction/process_tw_data.sh /gpfsscratch/rech/imi/usc19dv/data/UR5_processed/
