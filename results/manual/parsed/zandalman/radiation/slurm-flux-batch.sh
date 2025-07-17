#!/bin/bash
#FLUX: --job-name=conspicuous-latke-8985
#FLUX: -t=180
#FLUX: --urgency=16

module load miniconda
conda activate /gpfs/loomis/project/phys678/conda_envs/phys678
python RTE.py
