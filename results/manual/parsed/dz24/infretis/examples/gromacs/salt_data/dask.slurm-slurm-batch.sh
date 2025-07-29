#!/bin/bash
#SBATCH --job-name=sl_test
#SBATCH --account=nv-ikj
#SBATCH --output=test-srun.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000
#SBATCH --time=00:05:00
#SBATCH --partition=CPUQ

date
rm -r 00*
module load GROMACS/2021.5-foss-2021b
source ./dask_venv/bin/activate
python3 ./scheduler.py >| out.txt
date
