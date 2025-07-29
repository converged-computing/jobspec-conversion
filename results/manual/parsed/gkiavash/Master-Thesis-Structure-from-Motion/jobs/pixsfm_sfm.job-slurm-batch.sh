#!/bin/bash
#SBATCH --job-name=pixsfm
#SBATCH --output=output_%j.txt
#SBATCH --error=errors_%j.txt
#SBATCH --mail-user=gkiavash@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:rtx
#SBATCH --mem=128G
#SBATCH --time=12:00:00
#SBATCH --partition=allgroups

cd $WORKING_DIR
srun singularity exec --writable --nv Master-Thesis-Structure-from-Motion/sif_files/pixsfm_1_0_4.sif python3 Master-Thesis-Structure-from-Motion/experiments/sfm_pixsfm/run.py /home/ghamsariki/Master-Thesis-Structure-from-Motion/pixsfm_project
