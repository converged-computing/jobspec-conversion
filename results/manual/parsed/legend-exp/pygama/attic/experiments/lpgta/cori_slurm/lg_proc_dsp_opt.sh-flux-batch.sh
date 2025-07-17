#!/bin/bash
#FLUX: --job-name=blank-leopard-2134
#FLUX: -t=43200
#FLUX: --urgency=16

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
