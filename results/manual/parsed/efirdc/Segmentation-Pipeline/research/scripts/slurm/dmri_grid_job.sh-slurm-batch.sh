#!/bin/bash
#SBATCH --account=def-uofavis-ab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100l:1
#SBATCH --mem=16G
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=8,13,17

export MPLBACKEND='agg'

nvidia-smi
module load python/3.8
source ~/ENV_new/bin/activate
export MPLBACKEND=agg
python -m research.dmri_hippo.run augmentation_experiment_grid \
~/projects/def-uofavis-ab/shared_data/Diffusion_MRI_cropped.tar \
~/scratch/Checkpoints/ \
--work_path ${SLURM_TMPDIR}/${$SLURM_ARRAY_TASK_ID} \
--task_id $SLURM_ARRAY_TASK_ID
