#!/bin/bash
#FLUX: --job-name=collagen_segmentation
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=90000
#FLUX: --urgency=16

export NEPTUNE_API_TOKEN='eyJhcGlfYWRkcmVzcyI6Imh0dHBzOi8vYXBwLm5lcHR1bmUuYWkiLCJhcGlfdXJsIjoiaHR0cHM6Ly9hcHAubmVwdHVuZS5haSIsImFwaV9rZXkiOiJjNzllZGRmMC0yMzg2LTRhMzktOTk1MC1hNDc2MDlkNjVkYTMifQ=='

pwd; hostname; date
module load singularity
ml
date
nvidia-smi
export NEPTUNE_API_TOKEN="eyJhcGlfYWRkcmVzcyI6Imh0dHBzOi8vYXBwLm5lcHR1bmUuYWkiLCJhcGlfdXJsIjoiaHR0cHM6Ly9hcHAubmVwdHVuZS5haSIsImFwaV9rZXkiOiJjNzllZGRmMC0yMzg2LTRhMzktOTk1MC1hNDc2MDlkNjVkYTMifQ=="
singularity exec --nv collagen_segmentation_latest.sif python3 Collagen_Segmentation/CollagenSegMain.py train_inputs_single.json
date
