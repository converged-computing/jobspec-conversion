#!/bin/bash
#FLUX: --job-name=pusheena-muffin-1847
#FLUX: -n=6
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --priority=16

module load pytorch/1.13
. ./env.sh
declare -a models=(
    'stgcn-physical' 'stgcn-xy' 'stgcn' 'aagcn' 'ms-aagcn' 'ms-aagcn-fts'
)
for model in "${models[@]}"; do
    echo "Running prediction for model: $model"
    srun --exclusive -N1 -n1 predict.py --model-dir results/$model --output-dir predictions &
done
wait
echo "All prediction tasks completed."
