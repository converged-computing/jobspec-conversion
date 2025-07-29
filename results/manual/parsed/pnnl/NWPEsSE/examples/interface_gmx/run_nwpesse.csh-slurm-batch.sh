#!/bin/bash
#SBATCH --job-name=nwps
#SBATCH --account=emslc51753
#SBATCH --output=out.log
#SBATCH --error=err.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:59:39

date
source /etc/profile.d/modules.sh
module load  gcc/9.1.0
nwpesse input > job-nwps.log
date
