#!/bin/bash
#FLUX: --job-name=stud_exp
#FLUX: -c=2
#FLUX: -t=172800
#FLUX: --priority=16

source activate studiarbeit
nvidia-smi
echo -e "Node: $(hostname)"
echo -e "Job internal GPU id(s): $CUDA_VISIBLE_DEVICES"
echo -e "Job external GPU id(s): ${SLURM_JOB_GPUS}"
srun python -u main.py
