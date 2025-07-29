#!/bin/bash
#SBATCH --job-name=logical_fallacy_classifier
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=10240
#SBATCH --time=3-00:00:00
#SBATCH --chdir=/cluster/raid/home/zhivar.sourati/logical-fallacy-identification/CBR

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
