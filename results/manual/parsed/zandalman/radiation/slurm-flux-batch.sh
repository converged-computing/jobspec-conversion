#!/bin/bash
#FLUX --job-name=gloopy-train-2338
#FLUX -t=180
#FLUX --urgency=16

module load miniconda
conda activate /gpfs/loomis/project/phys678/conda_envs/phys678
python RTE.py
