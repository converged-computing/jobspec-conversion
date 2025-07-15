#!/bin/bash
#FLUX: --job-name=purple-kerfuffle-5686
#FLUX: -t=600
#FLUX: --priority=16

export MPICH_MAX_THREAD_SAFETY='multiple'
export PYTHONUNBUFFERED='1'
export OREMDA_DATA_DIR='$SCRATCH/data/oremda'
export OREMDA_CONTAINER_TYPE='singularity'
export OREMDA_SIF_DIR='images'
export OREMDA_PLASMA_MEMORY='5000000000'
export OREMDA_OPERATOR_CONFIG_FILE='operator_config.json'

home=/global/homes/p/psavery/
venv_path=$home/virtualenvs
oremda_path=$venv_path/oremda
export MPICH_MAX_THREAD_SAFETY=multiple
export PYTHONUNBUFFERED=1
export OREMDA_DATA_DIR=$SCRATCH/data/oremda
export OREMDA_CONTAINER_TYPE=singularity
export OREMDA_SIF_DIR=images
export OREMDA_PLASMA_MEMORY=5000000000
export OREMDA_OPERATOR_CONFIG_FILE="operator_config.json"
source $oremda_path/bin/activate
srun -n 20 oremda run pipeline.json
