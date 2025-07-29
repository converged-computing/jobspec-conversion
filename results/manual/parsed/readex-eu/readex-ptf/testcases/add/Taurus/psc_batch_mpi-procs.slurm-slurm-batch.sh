#!/bin/bash
#SBATCH --job-name=add
#SBATCH --account=p_readex
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=300M
#SBATCH --time=01:00:00
#SBATCH --partition=haswell

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

SCOREP_ENABLE_PROFILING=true
SCOREP_ENABLE_TRACING=false
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
psc_frontend --apprun=../add.exe --mpinumprocs=1 --tune=mpicap --phase="mainRegion" --force-localhost
exit 0
