#!/bin/bash
#SBATCH --job-name=lambdahat
#SBATCH --output=./outputs/slurm_logs/slurm_%A_%a.out
#SBATCH --error=./outputs/slurm_logs/slurm_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=8096
#SBATCH --time=02:00:00
#SBATCH --partition=gpu-a100,gpu-a100-short,gpu-a100-preempt
#SBATCH --array=1-100

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
module load Python/3.10.4
source /home/elau1/venvgpu3.10/bin/activate
CMD=$(sed -n "${SLURM_ARRAY_TASK_ID}p" commands_random_truth.txt)
echo "Executing command: $CMD"
eval $CMD
deactivate
my-job-stats -a -n -s
