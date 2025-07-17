#!/bin/bash
#FLUX: --job-name=goodbye-squidward-5657
#FLUX: -c=4
#FLUX: --queue=short
#FLUX: -t=43200
#FLUX: --urgency=16

set -e # fail fully on first line failure
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
TIME_STR=$(date '+%m-%d_%H-%M-%S')
FILENAME=`echo "$JOB_CMD" | grep -o "name=.*\""`
FILENAME="${FILENAME}_${TIME_STR}.txt"
echo "srun --output ${HOME}/slurm_outputs/${FILENAME}.out singularity exec --nv --bind ${DATA}:${DATA} $SINGULARITY_CONTAINER_PATH python3 $JOB_CMD base_outdir=$BASE_OUTDIR ++$IRRED_LOSS_GENERATOR_COMMAND datamodule.data_dir=$DATA_DIR"
srun --output ${HOME}/slurm_outputs/${FILENAME}.out singularity exec --nv --bind ${DATA}:${DATA} $SINGULARITY_CONTAINER_PATH python3 $JOB_CMD base_outdir=$BASE_OUTDIR ++$IRRED_LOSS_GENERATOR_COMMAND datamodule.data_dir=$DATA_DIR
