#!/bin/bash
#FLUX: --job-name=denoiser_score_est_train_small_mag
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

export FASTMRI_DATA_DIR='$SCRATCH/'
export CHECKPOINTS_DIR='$SCRATCH/nsec_long'

set -x
cd $WORK/score-estimation-comparison
module purge
conda deactivate fastmri-tf-2.1.0
module load tensorflow-gpu/py3/2.3.0
export FASTMRI_DATA_DIR=$SCRATCH/
export CHECKPOINTS_DIR=$SCRATCH/nsec_long
opt[0]="-sn 1.0"
opt[1]="-sn 0.5"
opt[2]="-sn 0.1"
srun python ./nsec/mri/denoiser_training.py ${opt[$SLURM_ARRAY_TASK_ID]} -n 50000 -c CORPD_FBK -m -lr 0.0001
