#!/bin/bash
#FLUX: --job-name=sl_test
#FLUX: -n=2
#FLUX: --queue=CPUQ
#FLUX: -t=300
#FLUX: --urgency=16

date
rm -r 00*
module load GROMACS/2021.5-foss-2021b
source ./dask_venv/bin/activate
python3 ./scheduler.py >| out.txt
date
