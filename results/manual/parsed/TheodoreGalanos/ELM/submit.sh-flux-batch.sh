#!/bin/bash
#FLUX: --job-name=reclusive-fork-8992
#FLUX: --queue=lotus_gpu
#FLUX: -t=57600
#FLUX: --urgency=16

set -e # fail fully on first line failure
path_to_conda="/home/users/hyper1on/miniconda3"
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
regexp="run_name=(\S+)"
if [[ $JOB_CMD =~ $regexp ]]
then
    JOB_OUTPUT=${BASH_REMATCH[1]}
else
    echo "Error: did not find a run_name argument"
    exit 1
fi
if [ -f  "~/elm/logs/$JOB_OUTPUT/results.json" ]
then
    echo "Results already done - exiting"
    rm "slurm-${JOB_ID}.out"
    exit 0
fi
if [ -d  "~/elm/logs/$JOB_OUTPUT" ]
then
    echo "Folder exists, but was unfinished or is ongoing (no results.json)."
    echo "Starting job as usual"
    # It might be worth removing the folder at this point:
    # echo "Removing current output before continuing"
    # rm -r "$JOB_OUTPUT"
    # Since this is a destructive action it is not on by default
fi
source ${path_to_conda}/bin/activate elm
srun python $JOB_CMD
mv "slurm-${JOB_ID}.out" "/home/users/hyper1on/elm/logs/${JOB_OUTPUT}/"
