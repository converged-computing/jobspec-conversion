#!/bin/bash
#FLUX: --job-name=experiments
#FLUX: -c=16
#FLUX: --queue=brown,red
#FLUX: -t=129600
#FLUX: --urgency=16

hostname
module load poetry
poetry shell
input_arg="$1"  # Capture the first command line argument
python -W ignore -m src.worker_vs_gpt.prompt_augmentation_hf "$input_arg"
