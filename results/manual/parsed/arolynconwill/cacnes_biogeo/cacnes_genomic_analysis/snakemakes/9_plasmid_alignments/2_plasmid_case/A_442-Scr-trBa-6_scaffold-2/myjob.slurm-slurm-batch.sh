#!/bin/bash
#SBATCH --job-name=CaseScaff4.SM.main
#SBATCH --output=mainout.txt
#SBATCH --error=mainerr.txt
#SBATCH --mail-user=aconwill@mit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=1-00:00:00

bash snakemakeslurm.sh
echo Done!!!
