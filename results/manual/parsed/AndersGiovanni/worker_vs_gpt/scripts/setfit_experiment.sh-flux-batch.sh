#!/bin/bash
#FLUX: --job-name=experiments
#FLUX: -c=12
#FLUX: --queue=brown,red
#FLUX: -t=57600
#FLUX: --urgency=16

hostname
nvidia-smi
module load poetry
poetry shell
python -m src.worker_vs_gpt.setfit_classification
