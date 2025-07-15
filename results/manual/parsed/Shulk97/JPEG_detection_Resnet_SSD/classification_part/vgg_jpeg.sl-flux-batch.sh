#!/bin/bash
#FLUX: --job-name=psycho-cupcake-6038
#FLUX: -N=4
#FLUX: -c=7
#FLUX: --exclusive
#FLUX: --queue=gpu_k80
#FLUX: -t=172800
#FLUX: --priority=16

export PYTHONUSERBASE='$HOME/ssd/pao_jpeg_bis/classification_part'
export EXPERIMENTS_OUTPUT_DIRECTORY='/dlocal/run/$SLURM_JOB_ID'
export LOG_DIRECTORY='$HOME/pao/logs/'
export DATASET_PATH_TRAIN='/save/2017018/PARTAGE/'
export DATASET_PATH_VAL='/save/2017018/PARTAGE/'
export PROJECT_PATH='$HOME/ssd/pao_jpeg_bis/classification_part'

module load cuda/9.0
module load python3-DL/3.6.1
export PYTHONUSERBASE=$HOME/ssd/pao_jpeg_bis/classification_part
export EXPERIMENTS_OUTPUT_DIRECTORY=/dlocal/run/$SLURM_JOB_ID
export LOG_DIRECTORY=$HOME/pao/logs/
export DATASET_PATH_TRAIN=/save/2017018/PARTAGE/
export DATASET_PATH_VAL=/save/2017018/PARTAGE/
export PROJECT_PATH=$HOME/ssd/pao_jpeg_bis/classification_part
cd $HOME/ssd/pao_jpeg_bis/classification_part
srun python3 training.py -c config/resnetRGB --archi "resnet_rgb" --use_pretrained_weights "True" --horovod "True"
