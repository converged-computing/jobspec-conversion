#!/bin/bash
#FLUX: --job-name=LegalReasoning
#FLUX: --queue=small
#FLUX: --priority=16

module load cuda/9.2
echo $PWD
python3 main.py -m lstmibgan  > slurm-chargemodel-$SLURM_JOB_ID.out
