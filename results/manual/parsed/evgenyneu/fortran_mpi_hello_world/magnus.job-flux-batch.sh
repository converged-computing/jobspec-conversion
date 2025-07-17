#!/bin/bash
#FLUX: --job-name=hello_mpi_01
#FLUX: -N=2
#FLUX: --queue=workq
#FLUX: -t=10
#FLUX: --urgency=16

module swap PrgEnv-gnu PrgEnv-intel
module swap PrgEnv-cray PrgEnv-intel
srun --export=all ./build/hello_mpi
