#!/bin/bash
#SBATCH --job-name=SCMcG_Assignment_1
#SBATCH --account=teaching
#SBATCH --output=slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=80
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00

  module purge
  module load nvidia/sdk/21.3
  module load ansys/21.2
  module load anaconda/python-3.9.7/2021.11
/opt/software/scripts/job_prologue.sh  
python SCMcG_Assignment_1.py
/opt/software/scripts/job_epilogue.sh 
