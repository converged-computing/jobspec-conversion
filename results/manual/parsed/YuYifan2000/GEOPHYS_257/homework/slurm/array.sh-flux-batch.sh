#!/bin/bash
#FLUX: --job-name=purple-omelette-8230
#FLUX: --queue=preempt
#FLUX: -t=120
#FLUX: --priority=16

spack load python@3.10.8
python ./pi_random.py $SLURM_ARRAY_TASK_ID
