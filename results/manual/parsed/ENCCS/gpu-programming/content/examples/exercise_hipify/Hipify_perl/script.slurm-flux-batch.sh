#!/bin/bash
#FLUX: --job-name=test.hip
#FLUX: --queue=eap
#FLUX: -t=600
#FLUX: --urgency=16

module load CrayEnv
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
srun ./executable.hip.exe
