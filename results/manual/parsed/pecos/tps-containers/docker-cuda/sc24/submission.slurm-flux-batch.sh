#!/bin/bash
#FLUX: --job-name=blue-pancake-9125
#FLUX: --urgency=16

module purge
module load gcc/11.2.0 mvapich2/2.3.7 tacc-apptainer/1.1.8 cuda/12.2
ml list
MV2_SMP_USE_CMA=0 ibrun apptainer run --nv tps-bte-ls6_latest.sif /tps/build-gpu/src/tps-bte_0d3v.py -run input.ini
