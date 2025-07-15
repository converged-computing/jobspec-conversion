#!/bin/bash
#FLUX: --job-name=quirky-plant-9802
#FLUX: -c=6
#FLUX: -t=172800
#FLUX: --urgency=16

cd ..
py_main='main'
gpu=$CUDA_VISIBLE_DEVICES
dataset='domainnet'
domains=(real sketch painting)
exp=${dataset}
for source in ${domains[@]}
do
    for target in ${domains[@]}
    do
        if [[ "${source}" != "${target}" ]]
        then
            python ${py_main}.py --gpu ${gpu} --exp ${exp} --dataset ${dataset} --source ${source} --target ${target}
        fi
    done
done
