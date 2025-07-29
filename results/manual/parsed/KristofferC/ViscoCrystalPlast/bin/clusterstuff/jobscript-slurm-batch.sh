#!/bin/bash
#SBATCH --job-name=ConvGrainSize
#SBATCH --account=C3SE2017-1-8
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --partition=hebbe

. /apps/new_modules.sh
module load intel
JULIA_PATH=$SNIC_NOBACKUP/julia/
$JULIA_PATH/julia jobrun.jl
