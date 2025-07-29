#!/bin/bash
#SBATCH --job-name=frame_pred
#SBATCH --output=logs/train_simvp_%j.out
#SBATCH --mail-user=tk3309@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --mem=64GB
#SBATCH --time=1-01:00:00

singularity exec --nv \
	    --overlay /scratch/tk3309/DL24/overlay-50G-10M.ext3:rw \
	    /scratch/tk3309/DL24/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif \
	    /bin/bash -c "source /ext3/env.sh; python /scratch/tk3309/mask_dl_final/train.py"
