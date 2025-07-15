#!/bin/bash
#FLUX: --job-name=chocolate-animal-1806
#FLUX: --queue=gpu_p100
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
srun python3 training_dct_pascal_j2d_resnet.py -vd 0 --crop --p07p12 --reg --resnet --archi "ssd_custom" --restart $HOME"/ssd/9139_epoch-193_REPRISE.h5"
