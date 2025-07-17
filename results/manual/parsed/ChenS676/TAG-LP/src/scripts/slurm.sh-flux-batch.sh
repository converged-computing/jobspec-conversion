#!/bin/bash
#FLUX: --job-name=muffled-puppy-8857
#FLUX: -n=40
#FLUX: -t=7200
#FLUX: --urgency=16

module load devel/cmake/3.18
module load devel/cuda/11.4
module load devel/cuda/11.4
module load compiler/gnu/12.1
cd /pfs/work7/workspace/scratch/cc7738-prefeature1
source /home/kit/aifb/cc7738/anaconda3/etc/profile.d/conda.sh
conda activate base
conda activate subgraph_skeptch
