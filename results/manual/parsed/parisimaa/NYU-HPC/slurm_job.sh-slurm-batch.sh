#!/bin/bash
#SBATCH --job-name=CL_Gd
#SBATCH --output=/gpfs/scratch/pa2297/slurm_%j.out
#SBATCH --mail-user=PA2297@nyulangone.org
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=10GB
#SBATCH --time=2-00:00:00

module purge
module load singularity/3.7.1
singularity exec --nv --bind /gpfs/scratch/pa2297:/gpfs/scratch/pa2297 \
/gpfs/scratch/pa2297/Singularity/tf_lu.sif \
python /gpfs/scratch/pa2297/multi-contrast-contrastive-learning/Datagen/generate_constraint_maps.py \
--data_dir /gpfs/scratch/pa2297/Dataset/BraTS2021_Training_Data/ \
--save_dir /gpfs/scratch/pa2297/Constraint_Maps/ 
