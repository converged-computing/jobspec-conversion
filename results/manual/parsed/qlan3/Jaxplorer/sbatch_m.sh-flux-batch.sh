#!/bin/bash
#FLUX: --job-name=creamy-rabbit-5497
#FLUX: --priority=16

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
module load StdEnv/2020 gcc/9.3.0 cudacore/.11.4.2 cudnn/8.2.0 cuda/11.4 mujoco/2.3.6 python/3.11 scipy-stack/2022a arrow
source ~/envs/jaxplorer/bin/activate
parallel --ungroup --jobs procfile python main.py --config_file ./configs/${SLURM_JOB_NAME}.json --config_idx {1} --slurm_dir $SLURM_TMPDIR :::: job_idx_${SLURM_JOB_NAME}_${SLURM_ARRAY_TASK_ID}.txt
echo "Job finished with exit code $? at: `date`"
