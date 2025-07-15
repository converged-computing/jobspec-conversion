#!/bin/bash
#FLUX: --job-name=Unfolding
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --urgency=16

WORKDIR="/home/fm02/MEG_NEOS/NEOS"
SCRIPT="temp_UnfoldOverlapCorrection_allfixations.ipy"
LOGDIR="/home/fm02/Desktop/MEG_EOS_scripts/sbatch_out"
mkdir -p "$LOGDIR/tasks"
conda activate mnejl
echo "JOB $SLURM_JOB_ID STARTING"
echo "TASK $i STARTING"
srun --ntasks=1 \
    --output="$LOGDIR/tasks/slurm_%u_%x_%A_%a_%N_stdout_task_$i.log" \
    --exclusive "ipython" $SCRIPT $i &
echo "TASK $i PUSHED TO BACKGROUND"
wait
echo "JOB $SLURM_JOB_ID COMPLETED"
