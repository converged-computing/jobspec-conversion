#!/bin/bash
#FLUX: --job-name=delicious-bits-2460
#FLUX: -N=16
#FLUX: --queue=test
#FLUX: -t=600
#FLUX: --urgency=16

module load slurm_setup                      # necessary workaround on SuperMUC-NG!
module load paraview-prebuild/5.8.0_mesa     # Look for available modules! But use MESA!
mpiexec pvbatch main.py       # try srun or use mpiexec's "-laucher" options if this does not work out-of-the-box
