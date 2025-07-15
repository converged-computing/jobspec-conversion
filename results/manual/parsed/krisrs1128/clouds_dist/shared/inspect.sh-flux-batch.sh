#!/bin/bash
#FLUX: --job-name=nerdy-leopard-9256
#FLUX: -t=4800
#FLUX: --priority=16

cd $HOME/clouds_dist
module load singularity/3.4
singularity exec --nv --bind /scratch/sankarak/data/clouds,/scratch/sankarak/data/clouds,/scratch/sankarak/clouds \
            /scratch/sankarak/images/clouds.img \
            python3 -m shared.inspect -m state_latest.pt
