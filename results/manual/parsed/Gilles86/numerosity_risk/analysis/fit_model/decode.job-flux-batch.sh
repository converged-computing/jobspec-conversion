#!/bin/bash
#FLUX: --job-name=decode_numrisk
#FLUX: --queue=volta
#FLUX: -t=1800
#FLUX: --urgency=16

export PARTICIPANT_LABEL='$(printf "%02d" $SLURM_ARRAY_TASK_ID)'

module load volta
module load nvidia/cuda11.2-cudnn8.1.0
. $HOME/init_conda.sh
. $HOME/init_freesurfer.sh
export PARTICIPANT_LABEL=$(printf "%02d" $SLURM_ARRAY_TASK_ID)
source activate tf2-gpu
python $HOME/git/numerosity_risk/analysis/fit_model/decode.py $SLURM_ARRAY_TASK_ID --masks NPC1_L NPC1_R NPC_L NPC_R NPC1 NPC --progressbar --trialwise --sourcedata=/scratch/gdehol/ds-numrisk
python $HOME/git/numerosity_risk/analysis/fit_model/decode.py $SLURM_ARRAY_TASK_ID --masks NPC1_L NPC1_R NPC_L NPC_R NPC1 NPC --progressbar --sourcedata=/scratch/gdehol/ds-numrisk
