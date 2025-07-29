#!/bin/bash
#SBATCH --job-name=R14f
#SBATCH --account=OCE22003
#SBATCH --output=myjob.o%j
#SBATCH --error=myjob.e%j
#SBATCH --mail-user=yjzhang@vims.edu
#SBATCH --mail-type=all
#SBATCH --nodes=20
#SBATCH --ntasks=1120
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

module list
pwd
date
ibrun ./pschism_FRONTERA_TVD-VL  5
