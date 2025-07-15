#!/bin/bash
#FLUX: --job-name=simcse_similarity_calculations
#FLUX: -c=16
#FLUX: --queue=nodes
#FLUX: -t=259200
#FLUX: --urgency=16

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate general
dataset="data/coarsegrained"
dataset_mod=${dataset//"/"/_}
for split in "train" "dev" "test" "climate_test"
do
python -m cbr_analyser.case_retriever.transformers.empathy_similarity_calculations \
    --source_file "${dataset}/train.csv" \
    --target_file "${dataset}/${split}.csv" \
    --output_file "cache/${dataset_mod}/empathy_similarities_masked_articles_${split}.joblib" \
done
conda deactivate
