#!/bin/bash
#SBATCH --job-name=Matlab-mcr-job
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000M
#SBATCH --time=03:00:00
#SBATCH --partition=compute

MCR=/global/software/matlab/mcr/v93
module load mcr/mcr
echo "Running on host: `hostname`"
echo "Current working directory is `pwd`"
echo "Starting run at: `date`"
./run_mycode.sh $MCR > mycode_${SLURM_JOBID}.out
echo "Program finished with exit code $? at: `date`"
