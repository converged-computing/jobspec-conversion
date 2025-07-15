#!/bin/bash
#FLUX: --job-name=LegalReasoning
#FLUX: --queue=htc
#FLUX: --priority=16

module load gpu/cuda/9.2.148
module load python/anaconda3/5.0.1
echo $PWD
python3 main_beer.py -m lstmibgan -a 2 > slurm-beermodel-$SLURM_JOB_ID.out
