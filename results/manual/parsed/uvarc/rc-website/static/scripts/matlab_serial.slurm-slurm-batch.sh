#!/bin/bash
#SBATCH --job-name=runSingleTest
#SBATCH --account=hpc_build
#SBATCH --output=runSingleTest_%A.out
#SBATCH --error=runSingleTest_%A.err
#SBATCH --mail-user=teh1m@virginia.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

module load matlab
nLoops=400; # number of iterations to perform
nDim=400; # Dimension of matrix to create
matlab -nodisplay -r "pcalc2(${nLoops},${nDim},'${SLURM_JOB_ID}'); exit;"
