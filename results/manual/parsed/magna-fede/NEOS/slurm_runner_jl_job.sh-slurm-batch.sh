#!/bin/bash
#SBATCH --job-name=unfold
#SBATCH --output=slurm_%u_%x_%j_stdout.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=3-00:00:00
#SBATCH --array=1,2,3,5,6,8,9,10,11,12,13,14,15,16,17,18,19,21,22,23,24,25,26,27,28,29,30

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
