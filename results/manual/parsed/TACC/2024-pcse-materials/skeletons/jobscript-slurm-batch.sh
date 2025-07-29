#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --output=myjob.o%j
#SBATCH --error=myjob.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=vm-small

module list
pwd
date
ibrun ./myprogram 
