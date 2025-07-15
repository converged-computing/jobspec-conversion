#!/bin/bash
#FLUX: --job-name=snl_tasks_atomate
#FLUX: --queue=matgen_prior
#FLUX: -t=345600
#FLUX: --priority=16

module unload python
module unload virtualenv
module load python/3.4-anaconda
source activate /global/u1/h/huck/ph_atomate
srun -n 1 python snl_tasks_atomate.py
