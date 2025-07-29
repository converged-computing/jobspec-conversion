#!/bin/bash
#SBATCH --job-name=domainnet
#SBATCH --output=output/%j.out
#SBATCH --error=output/%j.err
#SBATCH --mail-user=YOU@MAIL.COM
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:00:00

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
