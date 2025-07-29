#!/bin/bash
#SBATCH --job-name=decode_numrisk
#SBATCH --output=/home/cluster/gdehol/logs/fit_omega_%A-%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=00:20:00
#SBATCH --partition=volta

export PARTICIPANT_LABEL='$(printf "%02d" $SLURM_ARRAY_TASK_ID)'

module load volta
module load nvidia/cuda11.2-cudnn8.1.0
. $HOME/init_conda.sh
. $HOME/init_freesurfer.sh
export PARTICIPANT_LABEL=$(printf "%02d" $SLURM_ARRAY_TASK_ID)
source activate tf2-gpu
python $HOME/git/numerosity_risk/analysis/fit_model/fit_omega.py $SLURM_ARRAY_TASK_ID --masks NPC1_L NPC1_R NPC_L NPC_R NPC1 NPC --progressbar --trialwise --sourcedata=/scratch/gdehol/ds-numrisk
python $HOME/git/numerosity_risk/analysis/fit_model/fit_omega.py $SLURM_ARRAY_TASK_ID --masks NPC1_L NPC1_R NPC_L NPC_R NPC1 NPC --progressbar --sourcedata=/scratch/gdehol/ds-numrisk
