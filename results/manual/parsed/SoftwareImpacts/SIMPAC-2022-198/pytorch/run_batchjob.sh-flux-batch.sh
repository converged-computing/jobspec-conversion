#!/bin/bash
#FLUX: --job-name=reclusive-leader-9544
#FLUX: -c=8
#FLUX: --priority=16

module purge 
module load pytorch/1.11
pip install --user -r requirements_new.txt
srun python3 modeling.py run_indexed --index=$SLURM_ARRAY_TASK_ID --output-dir="./models/"
