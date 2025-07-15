#!/bin/bash
#FLUX: --job-name=doopy-carrot-5333
#FLUX: -c=4
#FLUX: -t=518400
#FLUX: --urgency=16

export HF_HOME='/data/vision/polina/scratch/wpq/github/huggingface_cache'

set -e # fail fully on first line failure
path_to_conda="/data/vision/polina/shared_software/miniconda3"
export HF_HOME='/data/vision/polina/scratch/wpq/github/huggingface_cache'
echo "Running on $(hostname)"
if [ -z "$SLURM_ARRAY_TASK_ID" ]
then
    # Not in Slurm Job Array - running in single mode
    JOB_ID=$SLURM_JOB_ID
    # Just read in what was passed over cmdline
    JOB_CMD="${@}"
else
    # In array
    JOB_ID="${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
    # Get the line corresponding to the task id
    JOB_CMD=$(head -n ${SLURM_ARRAY_TASK_ID} "$1" | tail -1)
fi
regexp="--output_dir_toplvl(\s+|=)(\S+)"
if [[ $JOB_CMD =~ $regexp ]]
then
    JOB_OUTPUT=${BASH_REMATCH[2]}
else
    echo "Error: did not find a --output_dir_toplvl argument"
    exit 1
fi
source ${path_to_conda}/bin/activate mi
cd /data/vision/polina/scratch/wpq/github/mi/local_mi_peiqi
echo srun $JOB_CMD --gpu_id=$SLURM_JOB_GPUS
srun $JOB_CMD --gpu_id=$SLURM_JOB_GPUS
[ ! -f "/data/vision/polina/scratch/wpq/github/interpretability/scripts/slurm-${JOB_ID}.err" ] || mv "/data/vision/polina/scratch/wpq/github/interpretability/scripts/slurm-${JOB_ID}.err" "${JOB_OUTPUT}/"
[ ! -f "/data/vision/polina/scratch/wpq/github/interpretability/scripts/slurm-${JOB_ID}.out" ] || mv "/data/vision/polina/scratch/wpq/github/interpretability/scripts/slurm-${JOB_ID}.out" "${JOB_OUTPUT}/"
