#!/bin/bash
#FLUX: --job-name=expensive-chair-1773
#FLUX: --urgency=16

echo "Current working directory: `pwd`"
echo "Starting run at: `date`"
echo "Job Array ID / Job ID: $SLURM_ARRAY_JOB_ID / $SLURM_JOB_ID"
echo "This is job $SLURM_ARRAY_TASK_ID out of $SLURM_ARRAY_TASK_COUNT jobs"
echo "SLURM_TMPDIR: $SLURM_TMPDIR"
echo "SLURM_JOB_NODELIST: $SLURM_JOB_NODELIST"
cleanup()
{
    echo "Copy log files from temporary directory"
    sour=$SLURM_TMPDIR/$SLURM_JOB_NAME/.
    dest=./logs/$SLURM_JOB_NAME/
    echo "Source directory: $sour"
    echo "Destination directory: $dest"
    cp -rf $sour $dest
}
trap 'cleanup' USR1 EXIT
module load gcc/9.3.0 arrow/2.0.0 python/3.8 scipy-stack
source ~/envs/tianshou/bin/activate
parallel --ungroup --jobs procfile python main.py --config_file ./configs/${SLURM_JOB_NAME}.json --config_idx {1} --slurm_dir $SLURM_TMPDIR :::: job_idx_${SLURM_JOB_NAME}_${SLURM_ARRAY_TASK_ID}.txt
echo "Job finished with exit code $? at: `date`"
