#!/bin/bash
#SBATCH --job-name=runMultiple
#SBATCH --account=hpc_build
#SBATCH --output=runMultiple_%A_%a.out
#SBATCH --error=runMultiple_%A_%a.err
#SBATCH --mail-user=teh1m@virginia.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=8
#SBATCH --array=1-5

export slurm_ID='${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}'
export numWorkers='$((SLURM_NTASKS-1))'

module purge
module load matlab
export slurm_ID="${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
export numWorkers=$((SLURM_NTASKS-1))
nLoops=400; # number of iterations to perform
nDim=400; # Dimension of matrix to create
matlab -nodisplay  -r \
"setPool1; pcalc2(${nLoops},${nDim},'${slurm_ID}');exit;"
