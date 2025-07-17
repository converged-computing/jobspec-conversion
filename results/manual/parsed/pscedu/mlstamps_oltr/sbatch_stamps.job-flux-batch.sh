#!/bin/bash
#FLUX: --job-name=ornery-animal-9180
#FLUX: --queue=GPU-shared
#FLUX: -t=172800
#FLUX: --urgency=16

set +x
cd  ${PROJECT}/${USER}/mlstamps_oltr/
conda activate mlstamps
CUDA_VISIBLE_DEVICES=0 python inference.py --config config/stamps/stage_2_meta_embedding.py --test_open
