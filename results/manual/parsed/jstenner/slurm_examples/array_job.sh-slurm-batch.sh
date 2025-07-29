#!/bin/bash
#SBATCH --job-name=array_job_test
#SBATCH --output=array_%A-%a.out
#SBATCH --mail-user=<email_address>
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1gb
#SBATCH --time=00:05:00
#SBATCH --array=1-5

pwd; hostname; date
echo This is task $SLURM_ARRAY_TASK_ID
date
