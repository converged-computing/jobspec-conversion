#!/bin/bash
#FLUX: --job-name=anxious-peas-0678
#FLUX: -c=8
#FLUX: -t=43200
#FLUX: --priority=16

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
