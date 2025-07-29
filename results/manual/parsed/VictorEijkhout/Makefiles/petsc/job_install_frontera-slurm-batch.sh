#!/bin/bash
#SBATCH --job-name=petscinstalljob
#SBATCH --account=A-ccsc
#SBATCH --output=petscinstalljob.o%j
#SBATCH --error=petscinstalljob.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00
#SBATCH --partition=small

module list
pwd
date
./install_all.sh -j 50
