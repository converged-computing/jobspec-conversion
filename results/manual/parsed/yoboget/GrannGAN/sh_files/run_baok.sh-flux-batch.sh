#!/bin/bash
#FLUX: --job-name=jobname
#FLUX: --queue=private-kalousis-gpu
#FLUX: -t=86400
#FLUX: --priority=16

srun singularity exec --nv pytorch_geo.sif python3 ~/CGAN-graph-generic/main.py --data_path=/home/users/b/boget3/data/
