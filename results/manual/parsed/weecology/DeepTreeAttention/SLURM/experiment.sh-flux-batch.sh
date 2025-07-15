#!/bin/bash
#FLUX: --job-name=DeepTreeAttention
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

ulimit -c 0
module load git gcc
git checkout $1
source activate DeepTreeAttention
cd ~/DeepTreeAttention/
branch_name=$((git symbolic-ref HEAD 2>/dev/null || echo "(unnamed branch)")|cut -d/ -f3-)
commit=$(git log --pretty=format:'%H' -n 1)
python train.py $branch_name $commit
