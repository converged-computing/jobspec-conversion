#!/bin/bash
#FLUX: --job-name=fat-pedo-7056
#FLUX: --queue=gpu
#FLUX: -t=144000
#FLUX: --urgency=16

module purge
module load gcc cuda cudnn mvapich2 openblas
deactivate
source ~/lpdi_fs/masif/tensorflow-1.12/bin/activate
./train_nn.sh nn_models.sc05.all_feat.custom_params.py
