#!/bin/bash
#FLUX: --job-name=nofc_sampling_mri
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

export FASTMRI_DATA_DIR='$SCRATCH/'
export CHECKPOINTS_DIR='$SCRATCH/nsec_nofc/'
export FIGURES_DIR='$SCRATCH/nsec_figures/sampling_nofc_sn${opt[$SLURM_ARRAY_TASK_ID]}/'

set -x
cd $WORK/score-estimation-comparison
module purge
conda deactivate fastmri-tf-2.1.0
module load tensorflow-gpu/py3/2.3.0
opt[0]='0.1'
opt[1]='0.5'
opt[2]='1.0'
opt[3]='2.0'
opt[4]='5.0'
opt[5]='10.0'
opt[6]='0.'
export FASTMRI_DATA_DIR=$SCRATCH/
export CHECKPOINTS_DIR=$SCRATCH/nsec_nofc/
export FIGURES_DIR=$SCRATCH/nsec_figures/sampling_nofc_sn${opt[$SLURM_ARRAY_TASK_ID]}/
srun python ./nsec/mri/sampling.py -ns 100000 --nps-train 50.0 -b 2 -c CORPD_FBK -is 64 -sn ${opt[$SLURM_ARRAY_TASK_ID]} --no-fcon
