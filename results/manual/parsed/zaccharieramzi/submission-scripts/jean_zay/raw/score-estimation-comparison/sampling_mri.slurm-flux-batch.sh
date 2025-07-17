#!/bin/bash
#FLUX: --job-name=sampling_mri
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

export FASTMRI_DATA_DIR='$SCRATCH/'
export CHECKPOINTS_DIR='$SCRATCH/nsec_no_sn'
export FIGURES_DIR='$SCRATCH/nsec_figures/sampling_no_sn_hd'

set -x
cd $WORK/score-estimation-comparison
module purge
conda deactivate fastmri-tf-2.1.0
module load tensorflow-gpu/py3/2.3.0
export FASTMRI_DATA_DIR=$SCRATCH/
export CHECKPOINTS_DIR=$SCRATCH/nsec_no_sn
export FIGURES_DIR=$SCRATCH/nsec_figures/sampling_no_sn_hd
srun python ./nsec/mri/sampling.py -ns 100000 -b 2 -c CORPD_FBK -sn 0. --nps-train 50.0
