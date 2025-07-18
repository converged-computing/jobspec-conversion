#!/bin/bash
#FLUX: --job-name=526_infer
#FLUX: -t=7200
#FLUX: --urgency=16

export nnUNet_raw_data_base='/scratch.global/reine097/nnUNet/nnUNet_raw_data_base'
export nnUNet_preprocessed='/scratch.global/reine097/nnUNet/nnUNet_raw_data_base/nnUNet_preprocessed'
export RESULTS_FOLDER='/home/feczk001/shared/data/nnUNet/nnUNet_raw_data_base/nnUNet_trained_models'

sbatch <<EOT
module load gcc cuda/11.2
source /common/software/install/migrated/anaconda/anaconda3-2018.12/etc/profile.d/conda.sh
module load conda
conda activate /home/support/public/pytorch_1.11.0_agate
export nnUNet_raw_data_base="/scratch.global/reine097/nnUNet/nnUNet_raw_data_base"
export nnUNet_preprocessed="/scratch.global/reine097/nnUNet/nnUNet_raw_data_base/nnUNet_preprocessed"
export RESULTS_FOLDER="/home/feczk001/shared/data/nnUNet/nnUNet_raw_data_base/nnUNet_trained_models"
nnUNet_predict -i /scratch.global/reine097/nnUNet/nnUNet_raw_data_base/nnUNet_raw_data/Task526_BobsRepo/imagesTs/ -o /scratch.global/reine097/nnUNet/nnUNet_raw_data_base/nnUNet_raw_data/Task526_BobsRepo/labelsTs/ -t 526 -m 3d_fullres
EOT
