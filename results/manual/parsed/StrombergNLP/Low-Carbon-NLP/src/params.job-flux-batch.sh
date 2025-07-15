#!/bin/bash
#FLUX: --job-name=params
#FLUX: -c=6
#FLUX: --queue=red
#FLUX: -t=259200
#FLUX: --urgency=16

module load Python/3.7.4-GCCcore-8.3.0
pip3 install --user datasets transformers carbontracker deepspeed
pip3 install --user torch torchvision pymongo
python3 opt_csv.py $SLURM_JOB_ID $1
