#!/bin/bash
#FLUX: --job-name=logical_fallacy_classifier
#FLUX: -c=8
#FLUX: --queue=nodes
#FLUX: -t=259200
#FLUX: --urgency=16

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate general
for dataset in "data/masked"
do
dataset_mod=${dataset//"/"/_}
echo $dataset_mod
python -m cbr_analyser.case_retriever.transformers.amr_encoded_similarity_calculations \
    --source_file "${dataset}/train.csv" \
    --task save_embeddings \
    --output_file "cache/${dataset_mod}/amr_encodings_train.joblib"
python -m cbr_analyser.case_retriever.transformers.amr_encoded_similarity_calculations \
    --source_file "${dataset}/dev.csv" \
    --task save_embeddings \
    --output_file "cache/${dataset_mod}/amr_encodings_dev.joblib"
python -m cbr_analyser.case_retriever.transformers.amr_encoded_similarity_calculations \
    --source_file "${dataset}/test.csv" \
    --task save_embeddings \
    --output_file "cache/${dataset_mod}/amr_encodings_test.joblib"
python -m cbr_analyser.case_retriever.transformers.amr_encoded_similarity_calculations \
    --source_file "cache/${dataset_mod}/amr_encodings_train.joblib" \
    --target_file "cache/${dataset_mod}/amr_encodings_train.joblib" \
    --task generate_similarities \
    --output_file "cache/${dataset_mod}/amr_similarities_train.joblib"
python -m cbr_analyser.case_retriever.transformers.amr_encoded_similarity_calculations \
    --source_file "cache/${dataset_mod}/amr_encodings_dev.joblib" \
    --target_file "cache/${dataset_mod}/amr_encodings_train.joblib" \
    --task generate_similarities \
    --output_file "cache/${dataset_mod}/amr_similarities_dev.joblib"
python -m cbr_analyser.case_retriever.transformers.amr_encoded_similarity_calculations \
    --source_file "cache/${dataset_mod}/amr_encodings_test.joblib" \
    --target_file "cache/${dataset_mod}/amr_encodings_train.joblib" \
    --task generate_similarities \
    --output_file "cache/${dataset_mod}/amr_similarities_test.joblib"
done
conda deactivate
