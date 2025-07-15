#!/bin/bash
#FLUX: --job-name=tart-animal-0264
#FLUX: --queue=parallel
#FLUX: -t=28800
#FLUX: --priority=16

export PYTHONPATH='$PWD" '

echo STARTING AT `date`
module load intel/18.0.2
module load python/3.6.5
module load cmake/3.11.1 # for pysap
source venvs/lisa/bin/activate
export PYTHONPATH="$PWD" 
srun python pipelines/pipeline.py pipelines/SDC2_full.config 3025 $DOMAIN_INDEX
echo FINISHED at `date`
