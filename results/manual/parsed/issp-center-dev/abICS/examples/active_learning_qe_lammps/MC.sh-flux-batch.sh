#!/bin/bash
#FLUX: --job-name=conspicuous-toaster-3111
#FLUX: -n=8
#FLUX: --queue=i8cpu
#FLUX: -t=1800
#FLUX: --urgency=16

srun -n 8 abics_sampling input.toml >> abics_sampling.out
echo Done
