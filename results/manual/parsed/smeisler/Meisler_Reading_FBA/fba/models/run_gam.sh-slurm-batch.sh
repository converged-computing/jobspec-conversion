#!/bin/bash
#SBATCH --job-name=ModelArray
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=50GB
#SBATCH --time=7-00:00:00

config=/PATH/TO/config
source $config
set -eu # Stop on errors
args=($@)
models=(${args[@]:0})
model=${models[${SLURM_ARRAY_TASK_ID}]}
IMG=/PATH/TO/modelarray_0.1.2.img
echo $model
singularity exec -B $base,$model --cleanenv ${IMG} Rscript $model "$outdir"
