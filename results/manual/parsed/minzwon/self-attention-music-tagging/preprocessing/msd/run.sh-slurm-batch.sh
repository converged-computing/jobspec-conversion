#!/bin/bash
#SBATCH --output=logs/iter_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=intel
#SBATCH --chdir=/homedtic/mwon/codes/music-tagging-attention/preprocessing/msd/
#SBATCH --array=1-20:1

module load Python/3.6.4-foss-2017a 
source /homedtic/mwon/envs/intel/bin/activate
python -u preprocess.py run '/datasets/MTG/audio/incoming/millionsong-audio/mp3/' '/homedtic/mwon/dataset/msd/' ${SLURM_ARRAY_TASK_ID} 20
