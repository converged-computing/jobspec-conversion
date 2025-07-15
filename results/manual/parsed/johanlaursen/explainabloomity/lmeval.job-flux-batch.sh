#!/bin/bash
#FLUX: --job-name=lovable-signal-4856
#FLUX: -c=8
#FLUX: --queue=red,brown
#FLUX: -t=44100
#FLUX: --urgency=16

nvidia-smi
module load Anaconda3
conda activate lmeval
tasks=(
    "lambada_openai"
    "paws_en"
    "hellaswag"
    "arc_easy"
    "blimp_ellipsis_n_bar_1"
    "blimp_irregular_plural_subject_verb_agreement_1"
)
output_path=""
metrics=(
    "cosine_cosine"
    # "euclidean_euclidean"
    # "cosine_random"
    # "euclidean_random"
)
prune_ratios=(
    "0.25"
    "0.5"
    "0.75"
)
path="/home/data_shares/mapillary/thesis_models/pruned_models/"
model="opt-13b"
prunetask=$1
prunemethod=$2
echo "model=${model}"
echo "prunetask=${prunetask}"
echo "prune_method=${prunemethod}"
for task in "${tasks[@]}"
do
    for metric in "${metrics[@]}"
    do
        for prune_percent in "${prune_ratios[@]}"
        do
            model_path="${model}/${prunemethod}/${prunetask}/${metric}/${prune_percent}"
            model_args="pretrained=${path}${model_path}/model,dtype=float16"
            echo "path=${path}${model_path}/model"
            lm_eval --model "hf" \
            --model_args $model_args  \
            --tasks $task  \
            --batch_size "auto" \
            --device "cuda:0" \
            --output_path "results/${task}/${model_path}" \
            --num_fewshot "0" \
            --write_out
        done
    done
done
