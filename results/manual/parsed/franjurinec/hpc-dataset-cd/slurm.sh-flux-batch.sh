#!/bin/bash
#FLUX: --job-name=fusion-data-pipeline
#FLUX: --queue=medium
#FLUX: -t=10800
#FLUX: --urgency=16

module load python-data
srun python workflow.py
