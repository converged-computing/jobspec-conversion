#!/bin/bash
#SBATCH --job-name=manifoldFDAgeodesic
#SBATCH --mail-user=susan.wei@unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=02:00:00
#SBATCH --partition=cloud
#SBATCH --array=1-2400%60

i=${SLURM_ARRAY_TASK_ID}
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
module load MATLAB
R --vanilla < spartanSim.R
