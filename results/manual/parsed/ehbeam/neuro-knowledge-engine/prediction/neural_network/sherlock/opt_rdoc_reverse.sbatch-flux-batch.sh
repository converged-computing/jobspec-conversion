#!/bin/bash
#FLUX: --job-name=op_rdo_reverse
#FLUX: -t=604800
#FLUX: --urgency=16

module load python/3.6 py-pytorch/1.0.0_py36 viz py-matplotlib/3.1.1_py36
srun python3 opt_rdoc_reverse.py
