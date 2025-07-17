#!/bin/bash
#FLUX: --job-name=param_recov_config
#FLUX: -c=8
#FLUX: -t=64800
#FLUX: --urgency=16

source /users/afengler/.bashrc
module load cudnn/8.1.0
module load cuda/11.1.1
module load gcc/10.2
conda deactivate
conda deactivate
conda activate lanfactory
param_recov_n_data_sets=1000
param_recov_n_subjects=10
param_recov_n_trials_per_subject=1000
param_recov_n_lans_to_pick=10
param_recov_n_burn=1000
param_recov_n_mcmc=5000
param_recov_n_chains=2
while [ ! $# -eq 0 ]
    do
        case "$1" in
            --networks_path | -n)
                networks_path=$2
                ;;
            --model | -m)
                model=$2
                ;;
            --param_recov_n_data_sets | -d)
                echo "passing number of networks $2"
                param_recov_n_data_sets=$2
                ;;
            --param_recov_n_subjects | -s)
                echo "passing deep learning backend specification: $2"
                param_recov_n_subjects=$2
                ;;
            --param_recov_n_trials_per_subject | -p)
                echo "passing number of networks $2"
                param_recov_n_trials_per_subject=$2
                ;;
            --param_recov_n_lans_to_pick| -l)
                echo "passing number of networks $2"
                param_recov_n_lans_to_pick=$2
                ;;
            --param_recov_n_burn | -b)
                echo "passing number of networks $2"
                param_recov_n_burn=$2
                ;;
            --param_recov_n_mcmc | -d)
                echo "passing number of networks $2"
                param_recov_n_mcmc=$2
                ;;
            --param_recov_n_chains | -d)
                echo "passing number of networks $2"
                pram_recov_n_chains=$2
        esac
        shift 2
    done
python -u scripts/make_param_recov_configs.py --model $model \
                        --networks_path $networks_path \
                        --param_recov_n_data_sets $param_recov_n_data_sets \
                        --param_recov_n_subjects $param_recov_n_subjects \
                        --param_recov_n_trials_per_subject $param_recov_n_trials_per_subject \
                        --param_recov_n_lans_to_pick $param_recov_n_lans_to_pick \
                        --param_recov_n_burn $param_recov_n_burn \
                        --param_recov_n_mcmc $param_recov_n_mcmc \
                        --param_recov_n_chains $param_recov_n_chains
