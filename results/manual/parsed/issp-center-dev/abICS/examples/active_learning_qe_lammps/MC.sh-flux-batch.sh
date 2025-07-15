#!/bin/bash
#FLUX: --job-name=crunchy-poodle-4836
#FLUX: -t=1800
#FLUX: --urgency=16

srun -n 8 abics_sampling input.toml >> abics_sampling.out
echo Done
