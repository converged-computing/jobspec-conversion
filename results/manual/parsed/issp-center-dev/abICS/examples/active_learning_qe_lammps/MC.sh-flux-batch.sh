#!/bin/bash
#FLUX: --job-name=crunchy-despacito-2579
#FLUX: -t=1800
#FLUX: --priority=16

srun -n 8 abics_sampling input.toml >> abics_sampling.out
echo Done
