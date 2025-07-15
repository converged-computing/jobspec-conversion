#!/bin/bash
#FLUX: --job-name=train.job
#FLUX: -t=172800
#FLUX: --priority=16

export TOKENIZERS_PARALLELISM='false'

nvidia-smi
                        #  --accelerator ddp
export TOKENIZERS_PARALLELISM=false
/cm/local/apps/python37/bin/python3.7  model/infer_model.py --ckpt ckpt/model_top10_debugged_retrained.ckpt \
                         --concept_map data/emotions_idx.json \
                         --dev_file data/dev_with_parse.json \
                         --paths_output_loc data/dev_output_emotions.csv
