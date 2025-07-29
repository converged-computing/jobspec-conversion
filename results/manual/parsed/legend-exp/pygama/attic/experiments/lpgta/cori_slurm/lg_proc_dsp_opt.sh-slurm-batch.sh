#!/bin/bash
#SBATCH --account=m2676
#SBATCH --output=/global/u1/l/lgprod/pygama/experiments/lpgta/cori_slurm/logs/cori-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --qos=shared
#SBATCH --constraint=haswell
#SBATCH --chdir=/global/u1/l/lgprod/pygama/experiments/lpgta

singularity
exec
docker:legendexp/legend-base:latest
cd /global/u1/l/lgprod/pygama/experiments/lpgta
date
scontrol show job $SLURM_JOB_ID
slurmd -C
echo "-----------------------------------------------------------"
echo srun shifter python processing.py --dg --q "run==30 and YYYYmmdd == '20200723' and hhmmss == '141228'" --r2d -o -v --bl $1 --bw $2
srun shifter python processing.py --dg --q "run==30 and YYYYmmdd == '20200723' and hhmmss == '141228'" --r2d -o -v --bl $1 --bw $2
echo "-----------------------------------------------------------"
echo sstat -j $SLURM_JOB_ID.batch --format=jobid,avecpu,avecpufreq,maxrss,maxvmsize,maxdiskread,maxdiskwrite,consumedenergy -P
sstat -j $SLURM_JOB_ID.batch --format=jobid,avecpu,avecpufreq,maxrss,maxvmsize,maxdiskread,maxdiskwrite,consumedenergy -P
date
