#!/bin/bash
#FLUX: --job-name=LegalReasoning
#FLUX: --queue=htc
#FLUX: --priority=16

module load gpu/cuda/9.2.148
echo $PWD
python3 main_small.py -m lstmibgan -s small  > slurm-charge_small_model-$SLURM_JOB_ID.out
