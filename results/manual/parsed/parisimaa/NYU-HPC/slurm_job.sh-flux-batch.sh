#!/bin/bash
#FLUX: --job-name=CL_Gd
#FLUX: -t=172800
#FLUX: --priority=16

module purge
module load singularity/3.7.1
singularity exec --nv --bind /gpfs/scratch/pa2297:/gpfs/scratch/pa2297 \
/gpfs/scratch/pa2297/Singularity/tf_lu.sif \
python /gpfs/scratch/pa2297/multi-contrast-contrastive-learning/Datagen/generate_constraint_maps.py \
--data_dir /gpfs/scratch/pa2297/Dataset/BraTS2021_Training_Data/ \
--save_dir /gpfs/scratch/pa2297/Constraint_Maps/ 
