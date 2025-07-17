#!/bin/bash
#FLUX: --job-name=muffled-bike-4293
#FLUX: -c=20
#FLUX: --queue=gpu
#FLUX: -t=21600
#FLUX: --urgency=16

export RUST_BACKTRACE='1'
export DATA='data/${MODEL_NAME}.hdf5'

export RUST_BACKTRACE=1
DIR_NAMES=($(ls FULL_ELASTICC_TRAIN | sort))
DIR_NAME=${DIR_NAMES[$SLURM_ARRAY_TASK_ID]}
MODEL_NAME=${DIR_NAME#ELASTICC_TRAIN_}
export DATA="data/${MODEL_NAME}.hdf5"
set -x
module load opence/1.5.1
cd ~/elasticc/ && conda activate elasticc
python3 ./extract_features.py -i ${DATA} -m model/parsnip-elasticc-extragal-SNe.pt -o features --device=cuda --s2n=5.0
