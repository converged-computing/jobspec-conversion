#!/bin/bash
#FLUX: --job-name=red-peanut-0734
#FLUX: --queue=preempt
#FLUX: -t=120
#FLUX: --urgency=16

spack load python@3.10.8
python ./pi_random.py $SLURM_ARRAY_TASK_ID
