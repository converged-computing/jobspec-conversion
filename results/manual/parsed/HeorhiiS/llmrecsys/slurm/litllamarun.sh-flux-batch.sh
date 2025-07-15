#!/bin/bash
#FLUX: --job-name=milky-toaster-7113
#FLUX: -t=19800
#FLUX: --urgency=16

module purge
source ~/.bashrc
conda activate llamaenv
python lit-llama/scripts/convert_checkpoint.py --checkpoint_dir "litllamadata/" --model_size 65B
