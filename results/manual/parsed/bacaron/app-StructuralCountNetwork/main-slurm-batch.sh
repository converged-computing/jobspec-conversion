#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=1

singularity exec -e docker://brainlife/mcr:r2019a ./compiled/main config.json
