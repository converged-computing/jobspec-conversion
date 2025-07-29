#!/bin/bash
#SBATCH --job-name=spockFarm
#SBATCH --output=log2-spockFarm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-00:00:00
#SBATCH --partition=Brody

module load julia/1.2.0
echo "Slurm Job ID, unique: $SLURM_JOB_ID"
echo "Slurm Array Task ID, relative: $SLURM_ARRAY_TASK_ID"
juliaScript=$1
shift
taskIDOffset=175
julia $juliaScript --bspockID ${SLURM_ARRAY_JOB_ID}_$SLURM_ARRAY_TASK_ID --myRunNumber $((SLURM_ARRAY_TASK_ID + taskIDOffset)) --onSpock --hostname spock $@
