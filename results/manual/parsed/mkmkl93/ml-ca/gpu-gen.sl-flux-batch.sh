#!/bin/bash
#FLUX: --job-name=expressive-carrot-9907
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

module load gpu/cuda/10.2 common/compilers/gcc/8.3.1
python3 ~/nasze-ca/src/prot-gen.py ${SLURM_ARRAY_TASK_ID}
