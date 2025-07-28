#!/bin/bash
#FLUX: --job-name=unfold
#FLUX: -c=4
#FLUX: -t=259200
#FLUX: --urgency=16

WORKDIR="/home/fm02/MEG_NEOS/NEOS"
SCRIPT1="$WORKDIR/unfold_eeg.jl"
SCRIPT2="$WORKDIR/unfold_meg.jl"
LOGDIR="/home/fm02/Desktop/MEG_EOS_scripts/sbatch_out"
mkdir -p "$LOGDIR/tasks"
echo "JOB $SLURM_JOB_ID STARTING"
srun --ntasks=1 \
    --output="$LOGDIR/tasks/slurm_%u_%x_%A_%a_%N_stdout_task_ $SLURM_ARRAY_TASK_ID.log" \
    julia $SCRIPT1 $SLURM_ARRAY_TASK_ID &
wait
srun --ntasks=1 \
    --output="$LOGDIR/tasks/slurm_%u_%x_%A_%a_%N_stdout_task_ $SLURM_ARRAY_TASK_ID.log" \
    julia $SCRIPT2 $SLURM_ARRAY_TASK_ID &
wait
echo "JOB $SLURM_JOB_ID COMPLETED"
