#!/bin/bash
#FLUX: --job-name=bloated-parsnip-7485
#FLUX: --priority=16

set +x
cd  ${PROJECT}/${USER}/mlstamps_oltr/
conda activate mlstamps
CUDA_VISIBLE_DEVICES=0 python inference.py --config config/stamps/stage_2_meta_embedding.py --test_open
