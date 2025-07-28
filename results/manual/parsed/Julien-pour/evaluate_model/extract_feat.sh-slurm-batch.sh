#!/bin/bash
#FLUX: --job-name=sft3b
#FLUX: -c=16
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load cpuarch/amd
module load pytorch-gpu/py3/2.0.1
cd $SCRATCH/evaluate_model 
python extract_feat.py -z $SCRATCH/evaluate_model/ -m ${SLURM_ARRAY_TASK_ID} -f full
