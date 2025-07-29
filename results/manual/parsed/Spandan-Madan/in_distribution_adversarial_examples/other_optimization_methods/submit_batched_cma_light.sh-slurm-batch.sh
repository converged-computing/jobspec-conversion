#!/bin/bash
#SBATCH --output=./slurm_outputs/slurm.%N.%j.out
#SBATCH --error=./slurm_outputs/slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00
#SBATCH --partition=cbmm
#SBATCH --array=0-119

bash batched_cma_light.sh ${SLURM_ARRAY_TASK_ID} resnet18_v7_40_final.pt categories_10_models_40.pkl
bash batched_cma_light.sh ${SLURM_ARRAY_TASK_ID} resnet18_pretrained_v7_40_normalized_final.pt categories_10_models_40.pkl
bash batched_cma_light.sh ${SLURM_ARRAY_TASK_ID} resnet18_antialiased_v7_40_normalized_final.pt categories_10_models_40.pkl
bash batched_cma_light.sh ${SLURM_ARRAY_TASK_ID} resnet18_v7_40_truly_shift_invariant_normalized.pt categories_10_models_40.pkl
bash batched_cma_light.sh ${SLURM_ARRAY_TASK_ID} train_v7_transformer_40_2.pt categories_10_models_40.pkl
bash batched_cma_light.sh ${SLURM_ARRAY_TASK_ID} train_v7_transformer_40_2_deit.pt categories_10_models_40.pkl
bash batched_cma_light.sh ${SLURM_ARRAY_TASK_ID} train_v7_transformer_40_2_deit_distilled.pt categories_10_models_40.pkl
