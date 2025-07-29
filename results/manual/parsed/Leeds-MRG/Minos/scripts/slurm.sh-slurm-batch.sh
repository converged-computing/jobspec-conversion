#!/bin/bash
#FLUX: --job-name=parallel_minos_job
#FLUX: -c=2
#FLUX: -t=900
#FLUX: --urgency=16

pwd; hostname; date
echo "Running Minos task $SLURM_JOBID on $SLURM_CPUS_ON_NODE CPU cores"
echo "Running task $SLURM_ARRAY_TASK_ID of $SLURM_ARRAY_TASK_MAX"
python3 scripts/minos_batch_run.py -c $1 --run_id $SLURM_ARRAY_TASK_ID  # run minos parallel run with job_id j
exit 0
