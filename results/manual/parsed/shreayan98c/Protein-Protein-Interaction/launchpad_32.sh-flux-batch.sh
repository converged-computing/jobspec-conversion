#!/bin/bash
#FLUX: --job-name="CS 601.471/671 final project"
#FLUX: --queue=ica100
#FLUX: -t=86400
#FLUX: --priority=16

export TRANSFORMERS_CACHE='/scratch4/danielk/schaud31'

module load anaconda
export TRANSFORMERS_CACHE=/scratch4/danielk/schaud31
conda activate ppi_pred # open the Python environment
srun python main.py train --batch-size 32 --epochs 10 --lr 1e-4 --small_subset False
