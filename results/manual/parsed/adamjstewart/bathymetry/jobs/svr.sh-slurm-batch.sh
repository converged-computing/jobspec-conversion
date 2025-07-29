#!/bin/bash
#SBATCH --job-name=svr
#SBATCH --mail-user=adamjs5@illinois.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=12
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=56

export LAUNCHER_WORKDIR='~/bathymetry'
export LAUNCHER_JOB_FILE='svr-job-file.txt'

spack --color=never env activate ~/bathymetry
module load launcher
export LAUNCHER_WORKDIR=~/bathymetry
export LAUNCHER_JOB_FILE=svr-job-file.txt
${LAUNCHER_DIR}/paramrun
