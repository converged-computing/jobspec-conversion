#!/bin/bash

# Flux directives translated from Slurm

# Job Name
#SBATCH --job-name=novel
#FLUX: -J novel

# Resource requests for the entire "array" of 100 tasks.
# Each original Slurm array task requested: 1 node, 1 task, 1 CPU, 300MB RAM.
# So, for 100 such tasks:
#SBATCH --nodes=1 (per array task)
#FLUX: -N 100

#SBATCH --ntasks=1 (per array task)
#FLUX: -n 100

#SBATCH --cpus-per-task=1
#FLUX: -c 1

#SBATCH --mem-per-cpu=300M (results in 300MB per task as cpus-per-task=1)
# Flux: request 300MB memory for each task.
#FLUX: --setopt=task.memory=300M

# Walltime
#SBATCH --time=03:02:00
#FLUX: -t 03:02:00

# Output and Error files
# Slurm's %x (job name) and %j (job ID, often masterID_taskID for arrays)
# Flux's {jobname} (or hardcoded name), {id} (job ID), {taskid} (task rank 0-N-1)
#SBATCH --output=logs/R-%x.%j.out
#FLUX: -o logs/R-novel.{id}.task{taskid}.out
#SBATCH --error=logs/R-%x.%j.err
#FLUX: -e logs/R-novel.{id}.task{taskid}.err

# Mail notifications
# SBATCH --mail-type=begin
# SBATCH --mail-type=end
# SBATCH --mail-type=fail
# SBATCH --mail-user=****
# Flux does not have direct built-in mail notification equivalents.
# This functionality would need to be scripted manually if required, e.g., using mailx.
# echo "Flux job {id} task {taskid} started" | mailx -s "Job Started" user@example.com
# (at the beginning of the script)
# trap 'echo "Flux job {id} task {taskid} failed" | mailx -s "Job Failed" user@example.com' ERR
# (at the beginning of the script for error notification)
# echo "Flux job {id} task {taskid} ended" | mailx -s "Job Ended" user@example.com
# (at the end of the script for success notification)

# Ensure the logs directory exists
mkdir -p logs

# Software environment setup
module purge
module load anaconda3/2021.5

# The main application command
# $SLURM_ARRAY_TASK_ID is replaced by $FLUX_TASK_ID (0-indexed task rank)
echo "Running python script for task $FLUX_TASK_ID"
python main.py $FLUX_TASK_ID 0 100 2000

#