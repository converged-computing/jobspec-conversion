#!/bin/bash
#FLUX: --job-name=expressive-pedo-4186
#FLUX: --priority=16

module load miniconda
conda activate /gpfs/loomis/project/phys678/conda_envs/phys678
python RTE.py
