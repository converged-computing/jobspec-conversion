#!/bin/bash
#SBATCH --job-name=explagraph_dev_file_generation
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=10240
#SBATCH --time=3-00:00:00
#SBATCH --partition=nodes
#SBATCH --chdir=/cluster/raid/home/zhivar.sourati/logical-fallacy-identification/CBR

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate general
python -m cbr_analyser.augmentations.prompt_gpt_j \
    --task output_explagraph \
    --input_file cache/masked_sentences_with_AMR_container_objects_with_belief_argument.joblib \
    --output_file cache/explagraph/train.tsv
conda deactivate
