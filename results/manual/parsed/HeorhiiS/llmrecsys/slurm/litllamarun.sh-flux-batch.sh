#!/bin/bash
#FLUX: --job-name=salted-spoon-7227
#FLUX: -t=19800
#FLUX: --priority=16

module purge
source ~/.bashrc
conda activate llamaenv
python lit-llama/scripts/convert_checkpoint.py --checkpoint_dir "litllamadata/" --model_size 65B
