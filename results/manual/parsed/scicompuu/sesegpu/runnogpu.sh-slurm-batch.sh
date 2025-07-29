#!/bin/bash
#SBATCH --account=g2021027
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:59:00

singularity run /proj/g2020014/nobackup/private/$@
