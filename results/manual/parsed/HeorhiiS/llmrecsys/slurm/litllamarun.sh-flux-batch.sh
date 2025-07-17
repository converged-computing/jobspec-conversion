#!/bin/bash
#FLUX: --job-name=expensive-signal-8889
#FLUX: -c=40
#FLUX: --queue=nvidia
#FLUX: -t=19800
#FLUX: --urgency=16

module purge
source ~/.bashrc
conda activate llamaenv
python lit-llama/scripts/convert_checkpoint.py --checkpoint_dir "litllamadata/" --model_size 65B
