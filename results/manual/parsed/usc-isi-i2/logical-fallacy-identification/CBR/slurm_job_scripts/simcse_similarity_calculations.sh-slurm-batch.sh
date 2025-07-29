#!/bin/bash
#SBATCH --job-name=simcse_similarity_calculations
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=10240
#SBATCH --time=3-00:00:00
#SBATCH --chdir=/cluster/raid/home/zhivar.sourati/logical-fallacy-identification/CBR

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate general
dataset="data/coarsegrained"
dataset_mod=${dataset//"/"/_}
for split in "train" "dev" "test" "climate_test"
do
python -m cbr_analyser.case_retriever.transformers.simcse_similarity_calculations \
    --source_file "${dataset}/train.csv" \
    --target_file "${dataset}/${split}.csv" \
    --output_file "cache/${dataset_mod}/simcse_similarities_masked_articles_${split}.joblib" \
done
conda deactivate
