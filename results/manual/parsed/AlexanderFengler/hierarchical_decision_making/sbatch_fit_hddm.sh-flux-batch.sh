#!/bin/bash
#FLUX: --job-name=chong_data_analysis
#FLUX: -c=12
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

source /users/afengler/.bashrc
module load cudnn/8.1.0
module load cuda/11.1.1
module load gcc/10.2
conda deactivate
conda deactivate
conda activate hddm-gpu
cd /users/afengler/data/proj_hierarchical_decision_making/hierarchical_decision_making/
echo "Starting script"
echo "Printing arguments"
echo $#
param_recov_mode="False"
while [ ! $# -eq 0 ]
    do
        case "$1" in
            --data_path | -d)
                echo "data_path is set to: $2"
                data_path=$2
                ;;
            --model | -m)
                echo "model: $2"
                model=$2
                ;;
            --dep_on_task | -d)
                echo "passing dependence on task as $2"
                dep_on_task=$2
                ;;
            --dep_on_coh | -d)
                echo "passing dependence on coherence as $2"
                dep_on_coh=$2
                ;;
            --is_group_model | -i)
                echo "group model is set to: $2"
                is_group_model=$2
                ;;
            --nmcmc | -n)
                echo "nmcmc set to: $2"
                nmcmc=$2
                ;;
            --nburn | -n)
                echo "nburn set to: $2"
                nburn=$2
                ;;
            --nchains | -nc)
                echo "nchains set to: $2"
                nchains=$2
                ;;
            --param_recov_mode | -pr)
                echo "param_recov_mode set to: $2"
                param_recov_mode=$2
                ;;
            --n_trials_per_subject | -ntps)
                echo "number of trials per subject (relevant for param recov in single subject mode) \n set to: $2"
                n_trials_per_subject=$2
                ;;
            --n_param_sets_by_recovery | -np)
                echo "n_param_sets_by_recovery set to: $2"
                n_param_sets_by_recovery=$2
        esac
        shift 2
    done
if [ $param_recov_mode == "False" ]
    then
        echo "Running chong data analysis"
        python -u fit_hddm.py --data_path $data_path \
                              --model $model \
                              --dep_on_task $dep_on_task \
                              --dep_on_coh $dep_on_coh \
                              --is_group_model $is_group_model \
                              --nmcmc $nmcmc \
                              --nburn $nburn \
                              --nchains $nchains
elif [ $param_recov_mode == "single_subject" ]
    then
        echo "Running parameter recovery in single subject mode"
        for ((i=1; i<=$n_param_sets_by_recovery; i++))
        do
            python -u fit_hddm_param_recov_single_subj.py --model $model \
                                                          --n_trials_per_subject $n_trials_per_subject \
                                                          --nmcmc $nmcmc \
                                                          --nburn $nburn \
                                                          --nchains $nchains
        done
elif [ $param_recov_mode == "chong" ]
    then
        echo "Running parameter recovery in chong mode"
        for ((i=1; i<=$n_param_sets_by_recovery; i++))
        do
            python -u fit_hddm_param_recov_chong.py --data_path $data_path \
                                                    --model $model \
                                                    --dep_on_task $dep_on_task \
                                                    --dep_on_coh $dep_on_coh \
                                                    --is_group_model $is_group_model \
                                                    --nmcmc $nmcmc \
                                                    --nburn $nburn \
                                                    --nchains $nchains
        done
fi
