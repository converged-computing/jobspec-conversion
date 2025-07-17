#!/bin/bash
#FLUX: --job-name=param_recov_postprocess
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --urgency=16

source /users/afengler/.bashrc
module load cudnn/8.1.0
module load cuda/11.1.1
module load gcc/10.2
conda deactivate
conda deactivate
conda activate lanfactory
model='ddm'
networks_path=None
param_recov_path=None
gelman_rubin_tolerance=1.05
while [ ! $# -eq 0 ]
    do
        case "$1" in
            --model | -m)
                model=$2
                ;;
            --networks_path | -l)
                networks_path=$2
                ;;
            --param_recov_path | -h)
                param_recov_path=$2
                ;;
            --gelman_rubin_tolerance | -g)
                gelman_rubin_tolerance=$2
        esac
        shift 2
    done
python -u scripts/postprocess_param_recov.py --model $model \
                                             --networks_path $networks_path \
                                             --param_recov_path $param_recov_path \
                                             --gelman_rubin_tolerance $gelman_rubin_tolerance 
