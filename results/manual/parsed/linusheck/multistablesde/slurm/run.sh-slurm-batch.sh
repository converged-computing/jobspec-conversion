#!/bin/bash
#SBATCH --job-name=pygpu
#SBATCH --account=thes1544
#SBATCH --output=/rwthfs/rz/cluster/home/wx133755/output/%x.%A_%4a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=08:00:00
#SBATCH --partition=c18g

echo "------------------------------------------------------------"
echo "SLURM JOB ID: $SLURM_JOBID"
echo "Running on nodes: $SLURM_NODELIST"
echo "------------------------------------------------------------"
module purge
cd ~/multistablesde/
./slurm/$1 ~/artifacts/${SLURM_ARRAY_JOB_ID}_$1/${SLURM_ARRAY_TASK_ID}/
