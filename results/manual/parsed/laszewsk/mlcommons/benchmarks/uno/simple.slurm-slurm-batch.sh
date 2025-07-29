#!/bin/bash
#FLUX: --job-name=uno-gpu-rivanna
#FLUX: -t=2400
#FLUX: --urgency=16

export USER_SCRATCH='/scratch/$USER'
export PROJECT_DIR='/project/bii_dsc_community/$USER/uno'
export PYTHON_DIR='$USER_SCRATCH/ENV3'
export PROJECT_DATA='$USER_SCRATCH/data'

export USER_SCRATCH=/scratch/$USER
export PROJECT_DIR=/project/bii_dsc_community/$USER/uno
export PYTHON_DIR=$USER_SCRATCH/ENV3
export PROJECT_DATA=$USER_SCRATCH/data
module purge
? module load anaconda3/2020.07
? module load cudnn/8.6.0.163-cuda11
source $PYTHON_DIR/bin/activate
which python
nvidia-smi
cd $PROJECT_DIR
mkdir outputs
cms gpu watch --gpu=0 --delay=0.5 --dense > outputs/gpu0.log &
python uno_mllog.py --config config_simple.yaml
seff $SLURM_JOB_ID
