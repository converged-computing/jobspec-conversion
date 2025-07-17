#!/bin/bash
#FLUX: --job-name=spicy-plant-0875
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

while getopts d:r:a:p:s:i:f:l:e: flag
do
    case "${flag}" in
        d) dataset_path=${OPTARG};;
        r) run_name_suffix=${OPTARG};;
        a) al_strategy=${OPTARG};;
        p) pretrained_model_name=${OPTARG};;
        s) add_dataset_size=${OPTARG};;
        i) init_dataset_size=${OPTARG};;
        f) finetuned_model_type=${OPTARG};;
        l) learning_rate=${OPTARG};;
        e) train_epochs=${OPTARG};;
    esac
done
echo "The arguments passed in are : $@"
if [[ -z "${PROJECT_DIR}" ]]; then
    export PROJECT_DIR="$(dirname "$(pwd)")"
fi
module load OpenBLAS/0.3.20-GCC-11.3.0
ml PyTorch/1.10.0-foss-2021a-CUDA-11.3.1
cd ..
source venv_2/bin/activate
python main.py --dataset_path $dataset_path --run_name_suffix $run_name_suffix --al_strategy $al_strategy --pretrained_model_name $pretrained_model_name --add_dataset_size $add_dataset_size --init_dataset_size $init_dataset_size --finetuned_model_type $finetuned_model_type --learning_rate $learning_rate --train_epochs $train_epochs
