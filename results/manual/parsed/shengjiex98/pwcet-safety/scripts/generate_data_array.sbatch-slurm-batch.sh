#!/bin/bash
#SBATCH --job-name=pwcet-safety-array
#SBATCH --output=../out/%A/slurm-%A.%a.out
#SBATCH --error=../err/%A/slurm-%A.%a.err
#SBATCH --mail-user=sxunique@cs.unc.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=8g
#SBATCH --time=01:00:00
#SBATCH --array=1-100%20

echo "SLURM_ARRAY_JOB_ID: $SLURM_ARRAY_JOB_ID."
echo "SLURM_ARRAY_TASK_ID: $SLURM_ARRAY_TASK_ID"
echo "Executing on the machine:" $(hostname)
module purge
module use $HOME/modulefiles
module add julia/1.10.0
echo "Start running Julia: " $(date)
SECONDS=0
(set -x; julia --project --threads=16 generate_data_ewb.jl)
echo "End running Julia: " $(date)
echo "Elapsed time: $SECONDS"
