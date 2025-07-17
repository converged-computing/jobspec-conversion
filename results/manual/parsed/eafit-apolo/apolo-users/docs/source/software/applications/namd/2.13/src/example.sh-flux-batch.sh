#!/bin/bash
#FLUX: --job-name=wps-wrf
#FLUX: -n=2
#FLUX: --queue=longjobs
#FLUX: -t=10800
#FLUX: --urgency=16

module load namd/2.13-gcc_CUDA
namd2 ubq_ws_eq.conf
