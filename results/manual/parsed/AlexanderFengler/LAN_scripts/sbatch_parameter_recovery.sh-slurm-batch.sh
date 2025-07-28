#!/bin/bash
#FLUX: --job-name=param_recov
#FLUX: -c=2
#FLUX: -t=86400
#FLUX: --urgency=16

source /users/afengler/.bashrc
module load cudnn/8.1.0
module load cuda/11.1.1
module load gcc/10.2
conda deactivate
conda deactivate
conda activate lanfactory
model_in_hddm=0
verbose=0
parallel=0
config_file=None
model_idx_low=0
model_idx_high=5
while [ ! $# -eq 0 ]
    do
        case "$1" in
            --config_file | -c)
                config_file=$2
                ;;
            --model_idx_low | -l)
                model_idx_low=$2
                ;;
            --model_idx_high | -h)
                model_idx_high=$2
                ;;
            --verbose | -v)
                verbose=$2
                ;;
            --parallel | -p)
                parallel=$2
                ;;
            --model_in_hddm | -m)
                model_in_hddm=$2
        esac
        shift 2
    done
echo "The config file supplied is: $config_file"
for ((i = $model_idx_low; i <= $model_idx_high; i++))
    do
        echo "Array ID $SLURM_ARRAY_TASK_ID "
        echo "Model idx iterator: "$i
        python -u scripts/run_hddm_model.py --config_file $config_file \
                                            --model_idx $i \
                                            --recov_idx $SLURM_ARRAY_TASK_ID \
                                            --parallel $parallel \
                                            --verbose $verbose \
                                            --hddm_basic 0
    done
if [[ $model_in_hddm -eq 1 ]]
    then
        echo "RUNNING HDDM BASIC SAMPLER"
        python -u scripts/run_hddm_model.py --config_file $config_file \
                                            --model_idx $i \
                                            --recov_idx $SLURM_ARRAY_TASK_ID \
                                            --parallel $parallel \
                                            --verbose $verbose \
                                            --hddm_basic 1
    fi
