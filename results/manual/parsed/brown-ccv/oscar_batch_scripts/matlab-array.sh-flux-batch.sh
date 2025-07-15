#!/bin/bash
#FLUX: --job-name=rainbow-hobbit-2192
#FLUX: --priority=16

echo "Running job array number: "$SLURM_ARRAY_TASK_ID
module load matlab/R2016a
matlab-threaded -nodisplay -nojvm -r "foo($SLURM_ARRAY_TASK_ID), exit"
