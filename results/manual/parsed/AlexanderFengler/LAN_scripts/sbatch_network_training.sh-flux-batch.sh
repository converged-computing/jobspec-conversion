#!/bin/bash
#FLUX: --job-name=model_trainer
#FLUX: -c=12
#FLUX: -t=86400
#FLUX: --urgency=16

source /users/afengler/.bashrc
conda deactivate
conda deactivate
conda activate lan_pipe
config_dict_key=None
config_path=None
networks_path="/users/afengler/data/proj_lan_pipeline/LAN_scripts/data/"
dl_workers=4
n_networks=2
backend="jax"
model="ddm"
echo "arguments passed to sbatch_network_training.sh $#"
while [ ! $# -eq 0 ]
    do
        case "$1" in
            --model | -m)
                echo "passing model as $2"
                model=$model
                ;;
            --config_path | -p)
                echo "passing config path $2"
                config_path=$2
                ;;
            --networks_path | -o)
                echo "passing output_folder $2"
                networks_path=$2
                ;;
            --n_networks | -n)
                echo "passing number of networks $2"
                n_networks=$2
                ;;
            --backend | -b)
                echo "passing deep learning backend specification: $2"
                backend=$2
                ;;
            --dl_workers | -d)
                echo "passing number of dataloader workers $2"
                dl_workers=$2
        esac
        shift 2
    done
echo "The config file supplied is: $config_path"
echo "The config dictionary key supplied is: $config_dict_key"
echo "Output folder is: $output_folder"
x='teststr' # defined only for the check below (testing whether SLURM_ARRAY_TASK_ID is set)
if [ -z ${SLURM_ARRAY_TASK_ID} ];
then
    for ((i = 1; i <= $n_networks; i++))
        do
            echo "NOW TRAINING NETWORK: $i of $n_networks"
            echo "No array ID"
            if [ "$backend" == "jax" ]; then
                python -u scripts/jax_training_script.py --model $model \
                                             --config_path $config_path \
                                             --config_dict_key 0 \
                                             --network_folder $networks_path \
                                             --dl_workers $dl_workers
            elif [ "$backend" == "torch" ]; then
                python -u scripts/torch_training_script.py --model $model \
                                                           --config_path $config_path \
                                                           --config_dict_key 0 \
                                                           --network_folder $networks_path \
                                                           --dl_workers $dl_workers
            fi
        done
else
    for ((i = 1; i <= $n_networks; i++))
        do
            echo "NOW TRAINING NETWORK: $i of $n_networks"
            echo "No array ID"
            if [ "$backend" == "jax" ]; then
                python -u scripts/jax_training_script.py --model $model \
                                                         --config_path $config_path \
                                                         --config_dict_key $SLURM_ARRAY_TASK_ID \
                                                         --network_folder $networks_path \
                                                         --dl_workers $dl_workers
            elif [ "$backend" == "torch" ]; then
                python -u scripts/torch_training_script.py --model $model \
                                                           --config_path $config_path \
                                                           --config_dict_key $SLURM_ARRAY_TASK_ID \
                                                           --network_folder $networks_path \
                                                           --dl_workers $dl_workers
            fi
        done
fi
