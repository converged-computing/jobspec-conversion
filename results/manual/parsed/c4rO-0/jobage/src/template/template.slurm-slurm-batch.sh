#!/bin/bash
#SBATCH --job-name=jbg_temp
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=!!!!PARTITION!!!!!
#SBATCH --constraint=ntasks-per-node=16
#SBATCH --chdir=./

