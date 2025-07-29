#!/bin/bash
#SBATCH --job-name=accuracy
#SBATCH --mail-user=tjzhao@ucdavis.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=50G
#SBATCH --time=13-03:00:00
#SBATCH --partition=bmh
#SBATCH --constraint=ntasks-per-node=1

module load julia
srun julia /group/qtlchenggrp/tianjing/encryption/jwas_ori.jl $1 $2 $3
