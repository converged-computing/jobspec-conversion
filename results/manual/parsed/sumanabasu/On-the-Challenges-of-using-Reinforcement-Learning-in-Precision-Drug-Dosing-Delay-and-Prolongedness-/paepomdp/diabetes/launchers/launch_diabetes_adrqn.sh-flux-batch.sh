#!/bin/bash
#FLUX: --job-name=Diabetes_ADRQN
#FLUX: -t=169200
#FLUX: --priority=16

module --quiet load anaconda/3
conda activate diabetes_pomdp
module --quiet load pytorch/1.8.1
cd /home/mila/b/basus/AAAIcode/paepomdp/diabetes/mains || exit
date;hostname;pwd
python adrqn_diabetes_main.py --array_id=$SLURM_ARRAY_TASK_ID --patient_name=child#009
date
nvidia-smi
