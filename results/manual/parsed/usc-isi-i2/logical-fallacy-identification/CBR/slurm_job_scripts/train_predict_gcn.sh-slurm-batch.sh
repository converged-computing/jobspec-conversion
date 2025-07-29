#!/bin/bash
#SBATCH --job-name=train_predict_GCN
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
python -m cbr_analyser.case_retriever.gcn.gcn \
    --task predict \
    --train_input_file cache/masked_sentences_with_AMR_container_objects_train.joblib \
    --dev_input_file cache/masked_sentences_with_AMR_container_objects_dev.joblib \
    --test_input_file cache/masked_sentences_with_AMR_container_objects_test.joblib \
    --predictions_path gcn_results \
    --model_path gcn_model.pt
conda deactivate
