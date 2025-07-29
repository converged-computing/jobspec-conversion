#!/bin/bash
#SBATCH --job-name=sample_job
#SBATCH --account=pXXXX
#SBATCH --output=outlog
#SBATCH --mail-user=email@u.northwestern.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:10:00
#SBATCH --partition=short
#SBATCH --constraint=ntasks-per-node=4,[quest8|quest9|quest10|quest11]

module purge all
module load paraview/5.9.0
mpi-pvbatch test-pvbatch.py
