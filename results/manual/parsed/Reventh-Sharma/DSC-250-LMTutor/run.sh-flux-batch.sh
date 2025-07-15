#!/bin/bash
#FLUX: --job-name=train_lmtutor
#FLUX: -c=16
#FLUX: --queue=gpu-shared
#FLUX: -t=10800
#FLUX: --urgency=16

export CACHE_FOLDER='/scratch/'${USER}'/job_'${SLURM_JOBID}'

declare -xr SINGUALRITY_MODULE='singularitypro/3.5'
export CACHE_FOLDER='/scratch/'${USER}'/job_'${SLURM_JOBID}
module purge
module load "${SINGUALRITY_MODULE}"
module list
printenv
MODEL_LIST=("hf_lmsys/vicuna-7b-v1.3" "hf_meta-llama/Llama-2-7b-chat-hf", "instruct_embedding")
RAND_CONTEXT_COUNT=("2500" "5000" "7500" "10000")
for MODEL in "${MODEL_LIST[@]}"
do
    for RAND_CONTEXT_COUNT in "${RAND_CONTEXT_COUNT[@]}"
    do
        if [ $counter -eq $SLURM_ARRAY_TASK_ID ]
            then
                echo "Running model: $MODEL with layer: $LAYER on GPU: $CUDA_VISIBLE_DEVICES for dataset: $DATASET"
                python run.py --prepare_dataset --dataset_name "squad" --dataset_split "validation" --embedding_model $MODEL --embed_device $CUDA_VISIBLE_DEVICES --hidden_state_id -1 --aggregation "mean" --use_random_contexts --random_contexts_count $RAND_CONTEXT_COUNT --llm_model $MODEL --llm_device $CUDA_VISIBLE_DEVICES
            fi
            ((counter++))
        done
    done
done
QUERY_CHOICE=("1", "2")
MODEL_LIST=("hf_lmsys/vicuna-7b-v1.3" "hf_meta-llama/Llama-2-7b-chat-hf")
for MODEL in "${MODEL_LIST[@]}"
do
    for QR_CHOICE in "${QUERY_CHOICE[@]}"
    do
        if [ $counter -eq $SLURM_ARRAY_TASK_ID ]
                then
                    echo "Running model: $MODEL with layer: $LAYER on GPU: $CUDA_VISIBLE_DEVICES for dataset: $DATASET"
                    python run.py --prepare_dataset --dataset_name "squad" --embedding_model $MODEL --embed_device $CUDA_VISIBLE_DEVICES --hidden_state_id -1 --aggregation "mean" --query_choice $QR_CHOICE
                fi
                ((counter++))
        done
    done
done
