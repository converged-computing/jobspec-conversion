#!/bin/bash
#SBATCH --job-name=demand_scenarios
#SBATCH --output=logs/%A_%a.out
#SBATCH --error=logs/%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6400
#SBATCH --time=3-00:00:00
#SBATCH --partition=shared
#SBATCH --array=1-40

module load lang/Anaconda3
source activate demand_system
echo ============================================================
echo running job: switch solve-scenarios --scenario-queue sq/$SLURM_ARRAY_JOB_ID --job-id "$SLURM_ARRAY_JOB_ID"_"$SLURM_ARRAY_TASK_ID" "$@" --tempdir ./tmp
echo ============================================================
echo
srun --unbuffered switch solve-scenarios --scenario-queue sq/$SLURM_ARRAY_JOB_ID --job-id "$SLURM_ARRAY_JOB_ID"_"$SLURM_ARRAY_TASK_ID" "$@" --tempdir ./tmp
