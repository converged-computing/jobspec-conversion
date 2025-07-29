#!/bin/bash
#SBATCH --account=def-uofavis-ab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100l:1
#SBATCH --mem=16G
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0

export MPLBACKEND='agg'

nvidia-smi
module load python/3.8
source ~/ENV_new/bin/activate
export MPLBACKEND=agg
python -m research.dmri_hippo.run cascade_experiment \
~/projects/def-uofavis-ab/shared_data/Diffusion_MRI/ \
~/projects/def-uofavis-ab/shared_data/Predictions/Diffusion_MRI_cropped/Priors/ \
~/scratch/Checkpoints/ \
--work_path ${SLURM_TMPDIR}/${SLURM_ARRAY_TASK_ID} \
--prior_label_name "whole_roi_pred_task502" \
--model_type "basic_unet" \
--fold $SLURM_ARRAY_TASK_ID \
--max_training_time "0-12:0:0" \
--num_cpu_threads 8 \
--group_name "cascade_tuning"
