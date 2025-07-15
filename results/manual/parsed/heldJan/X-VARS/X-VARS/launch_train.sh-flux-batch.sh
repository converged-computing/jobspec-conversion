#!/bin/bash
#FLUX: --job-name=nerdy-snack-5219
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=14700
#FLUX: --urgency=16

source /gpfs/home/acad/ulg-intelsig/jheld/anaconda3/etc/profile.d/conda.sh
conda activate vars-ex
accelerate launch --config_file /gpfs/home/acad/ulg-intelsig/jheld/.cache/huggingface/accelerate/default_config.yaml training.py
