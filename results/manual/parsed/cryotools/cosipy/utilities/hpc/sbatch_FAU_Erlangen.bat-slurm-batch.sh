#!/bin/bash
#SBATCH --job-name=Test_run
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

unset SLURM_EXPORT_ENV
module load intel64 netcdf 
/home/woody/gwgk/gwgk01/envs/karoshi/bin/python COSIPY.py
rm -r worker-* *.lock
