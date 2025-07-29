#!/bin/bash
#SBATCH --job-name=img_prep
#SBATCH --account=carlsonlab
#SBATCH --output=img_prep.out
#SBATCH --error=img_prep.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --partition=carlsonlab-gpu
#SBATCH --qos=low

srun singularity exec --nv --bind /work/ld243 /datacommons/carlsonlab/Containers/multimodal_gp.simg python Image_Preprocessing_1.py
