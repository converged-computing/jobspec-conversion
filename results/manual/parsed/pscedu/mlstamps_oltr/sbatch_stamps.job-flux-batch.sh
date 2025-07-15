#!/bin/bash
#FLUX: --job-name=hello-staircase-5801
#FLUX: --urgency=16

set +x
cd  ${PROJECT}/${USER}/mlstamps_oltr/
conda activate mlstamps
CUDA_VISIBLE_DEVICES=0 python inference.py --config config/stamps/stage_2_meta_embedding.py --test_open
