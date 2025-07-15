#!/bin/bash
#FLUX: --job-name=semantic_doremi
#FLUX: -N=4
#FLUX: --exclusive
#FLUX: --queue=g40
#FLUX: -t=86400
#FLUX: --priority=16

srun --account stablegpt sh $PWD/ray_worker.sh
