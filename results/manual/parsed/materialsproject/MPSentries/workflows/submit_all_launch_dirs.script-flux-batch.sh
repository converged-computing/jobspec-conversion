#!/bin/bash
#FLUX: --job-name=all_launch_dirs
#FLUX: --queue=matgen_prior
#FLUX: -t=86400
#FLUX: --priority=16

module unload python
module unload virtualenv
module load python/3.4-anaconda
module unload intel
source activate /global/u1/h/huck/ph_atomate
srun -n 1 python all_launch_dirs.py
