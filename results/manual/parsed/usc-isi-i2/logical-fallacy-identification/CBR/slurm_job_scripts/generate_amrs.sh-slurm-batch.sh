#!/bin/bash
#SBATCH --job-name=generate_amr_graphs
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
python cbr_analyser.amr.amr_extraction \
    --input_file ${input_file} \
    --output_file ${output_file} \
    --task amr_generation
conda deactivate
