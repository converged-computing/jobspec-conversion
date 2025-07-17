#!/bin/bash
#FLUX: --job-name=setDevice_acc
#FLUX: --queue=dev-g
#FLUX: -t=600
#FLUX: --urgency=16

module load CrayEnv
module load PrgEnv-cray
module load cray-mpich
module load craype-accel-amd-gfx90a
module load rocm
srun ./assignDevice.acc.exe | sort
echo 
