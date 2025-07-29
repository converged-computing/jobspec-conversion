#!/bin/bash
#FLUX: --job-name=vnn
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module purge 
module load pytorch/1.11
pip install --user -r requirements_new.txt
srun python3 modeling.py run_indexed --index=$SLURM_ARRAY_TASK_ID --output-dir="./models/"
