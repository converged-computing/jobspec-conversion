#!/bin/bash
#SBATCH --job-name=runParallelTest
#SBATCH --account=hpc_build
#SBATCH --output=runParallelTest_%A.out
#SBATCH --error=runParallelTest_%A.err
#SBATCH --mail-user=teh1m@virginia.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=8

export slurm_ID='${SLURM_JOB_ID}'
export numWorkers='$((SLURM_NTASKS-1))'

module load matlab
export slurm_ID="${SLURM_JOB_ID}"
export numWorkers=$((SLURM_NTASKS-1))
nLoops=400; # number of iterations to perform
nDim=400; # Dimension of matrix to create
matlab -nodisplay  -r \
 "setPool1; pcalc2(${nLoops},${nDim},'${slurm_ID}'); exit;"
