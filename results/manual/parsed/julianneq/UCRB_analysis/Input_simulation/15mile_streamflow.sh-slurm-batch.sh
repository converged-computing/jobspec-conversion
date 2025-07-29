#!/bin/bash
#SBATCH --job-name=streamflow
#SBATCH --output=../output/streamflow.out
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=compute
#SBATCH --constraint=ntasks-per-node=24

module load python
module load mpi4py
module load scipy
ibrun python 15mile_streamflow.py LHsamples_original_1000
