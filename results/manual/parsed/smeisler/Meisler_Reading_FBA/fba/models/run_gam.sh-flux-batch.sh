#!/bin/bash
#FLUX: --job-name=quirky-bike-3699
#FLUX: -c=32
#FLUX: -t=604800
#FLUX: --urgency=16

config=/PATH/TO/config
source $config
set -eu # Stop on errors
args=($@)
models=(${args[@]:0})
model=${models[${SLURM_ARRAY_TASK_ID}]}
IMG=/PATH/TO/modelarray_0.1.2.img
echo $model
singularity exec -B $base,$model --cleanenv ${IMG} Rscript $model "$outdir"
