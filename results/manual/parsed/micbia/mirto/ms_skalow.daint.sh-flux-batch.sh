#!/bin/bash
#FLUX: --job-name=ms
#FLUX: -t=9000
#FLUX: --urgency=16

module load daint-gpu
module load gcc/9.3.0
module load cudatoolkit/10.2.89_3.28-2.1__g52c0314
IDX_S=0
IDX_F="$((${SLURM_ARRAY_TASK_ID}+600))"
SKY_MODEL="gleam" #"ionpointbeamgf"
ROOT_NAME="coevalLC_256_train_190922_i${IDX_S}_dT${SKY_MODEL}_ch${IDX_F}_4h1d_256"
PATH_OUT="$SCRATCH/output_sdc3/dataLC_256_train_090523/ms_point/"
source /project/c31/codes/miniconda3/etc/profile.d/conda.sh
conda activate karabo-env
python karabo_ms_skalow.py $ROOT_NAME $PATH_OUT
conda deactivate
