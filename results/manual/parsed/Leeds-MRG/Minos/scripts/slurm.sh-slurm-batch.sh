#!/bin/bash
#SBATCH --job-name=parallel_minos_job
#SBATCH --output=logs/minos_batch-%A-%a.out
#SBATCH --mail-user=gyrc@leeds.ac.uk
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=2gb
#SBATCH --time=00:15:00

pwd; hostname; date
echo "Running Minos task $SLURM_JOBID on $SLURM_CPUS_ON_NODE CPU cores"
echo "Running task $SLURM_ARRAY_TASK_ID of $SLURM_ARRAY_TASK_MAX"
python3 scripts/minos_batch_run.py -c $1 --run_id $SLURM_ARRAY_TASK_ID  # run minos parallel run with job_id j
exit 0
