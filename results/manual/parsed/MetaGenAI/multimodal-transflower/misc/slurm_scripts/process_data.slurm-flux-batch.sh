#!/bin/bash
#FLUX: --job-name=process_data
#FLUX: -n=160
#FLUX: -c=2
#FLUX: -t=72000
#FLUX: --urgency=16

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
