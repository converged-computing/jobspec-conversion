#!/bin/bash
#SBATCH --output=terminal.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=02:00:00
#SBATCH --array=1-5000

export OMP_PROC_BIND='true'

export OMP_PROC_BIND=true
module load matlab
python triton_auto_run_RSTA.py $SLURM_ARRAY_TASK_ID $TMPDIR '../outputs/compare_run/'
