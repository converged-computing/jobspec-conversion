#!/bin/bash
#FLUX: --job-name=bloated-fudge-8616
#FLUX: --queue=gpu_k80
#FLUX: -t=172800
#FLUX: --urgency=16

export LOCAL_WORK_DIR='/home/2017018/tconst01/ssd/pao_jpeg_bis/localisation_part'
export DATASET_PATH='/save/2017018/PARTAGE/pascal_voc/'
export EXPERIMENTS_OUTPUT_DIRECTORY='/dlocal/run/$SLURM_JOB_ID'

module load cuda/9.0
module load python3-DL/3.6.1
export LOCAL_WORK_DIR=/home/2017018/tconst01/ssd/pao_jpeg_bis/localisation_part
export DATASET_PATH=/save/2017018/PARTAGE/pascal_voc/
export EXPERIMENTS_OUTPUT_DIRECTORY=/dlocal/run/$SLURM_JOB_ID
cd $HOME/ssd/pao_jpeg_bis/localisation_part
srun python3 evaluation.py --ssd_resnet -p07 -dp $HOME"/ssd/VOCdevkit/" --archi "cb5_only" $HOME"/ssd/9092_epoch-166_REPRISE.h5"
