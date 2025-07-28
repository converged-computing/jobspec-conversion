#!/bin/bash
#FLUX: --job-name=pi_acc
#FLUX: --exclusive
#FLUX: --queue=standard-g
#FLUX: -t=600
#FLUX: --urgency=16

export ALLINEA_STOP_AT_MAIN='1'

export ALLINEA_STOP_AT_MAIN=1
module load LUMI/22.12
module load partition/G
module load Linaro_Forge/23.0
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
ddt --connect srun -n 4 pi_openacc
