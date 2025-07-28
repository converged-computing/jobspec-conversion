#!/bin/bash
#FLUX: --job-name=general_task_vector_main
#FLUX: -t=3600
#FLUX: --urgency=16

export PATH_TO_STORAGE='/scratch/p313544/storage_cache/'

module purge
module load Python/3.10.8-GCCcore-12.2.0
module load CUDA/11.7.0
echo "Python version: $(python --version)"
echo $HF_HOME
nvidia-smi
pwd
PATH_TO_PRJ=/home1/p313544/Documents/general-task-vectors
export PATH_TO_STORAGE=/scratch/p313544/storage_cache/
cd $PATH_TO_PRJ
source .venv/bin/activate
echo "Executing python script..."
python -m atp_main \
    --model_name mistralai/Mistral-7B-Instruct-v0.2 \
    --dataset_name untruthful_train \
    --icl_examples 5 \
    --support 25 \
    --load_in_8bit \
    --max_new_tokens 100 \
python -m atp_main \
    --model_name mistralai/Mistral-7B-Instruct-v0.2 \
    --dataset_name truthful_train \
    --icl_examples 5 \
    --support 25 \
    --load_in_8bit \
    --max_new_tokens 100 \
python -m atp_main \
    --model_name mistralai/Mistral-7B-Instruct-v0.2 \
    --dataset_name cona-facts \
    --icl_examples 1 \
    --support 25 \
    --load_in_8bit \
    --max_new_tokens 100 \
