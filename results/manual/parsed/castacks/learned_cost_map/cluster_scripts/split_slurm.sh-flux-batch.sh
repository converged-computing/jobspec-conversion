#!/bin/bash
#FLUX: --job-name=create_split
#FLUX: --queue=gpu
#FLUX: -t=60
#FLUX: --urgency=16

EXE=/bin/bash
WORKING_DIR=/data/datasets/mguamanc/learned_cost_map/cluster_scripts
EXE_SCRIPT=$WORKING_DIR/create_split.sh
USER=mguamanc
nvidia-docker run --rm --ipc=host -e CUDA_VISIBLE_DEVICES='echo $CUDA_VISIBLE_DEVICES' -v /data/datasets:/data/datasets -v /home/$USER:/home/$USER -v /project:/project mguamanc/sara $EXE $EXE_SCRIPT
