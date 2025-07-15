#!/bin/bash
#FLUX: --job-name=swampy-hobbit-8393
#FLUX: --urgency=16

module load openmpi/4.0.5-skylake-gcc10.1
module load gcc/10.1.0
module load namd/2.14-mpi
source /work/hung_group/xu.jiam/miniconda3/bin/activate
python pair_cal.py
