#!/bin/bash
#SBATCH --job-name=add
#SBATCH --account=p_readex
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=300M
#SBATCH --time=01:00:00

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
psc_frontend --apprun=./add.exe --mpinumprocs=1 --tune=compilerflags  --force-localhost --phase="mainRegion" --cfs-config="cfs_config.cfg"
exit 0
