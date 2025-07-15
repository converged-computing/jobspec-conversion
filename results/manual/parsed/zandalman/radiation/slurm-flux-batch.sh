#!/bin/bash
#FLUX: --job-name=blue-leader-2443
#FLUX: --urgency=16

module load miniconda
conda activate /gpfs/loomis/project/phys678/conda_envs/phys678
python RTE.py
