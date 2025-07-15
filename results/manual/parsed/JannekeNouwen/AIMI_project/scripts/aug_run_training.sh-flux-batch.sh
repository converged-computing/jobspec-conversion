#!/bin/bash
#FLUX: --job-name=wobbly-punk-8935
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export nnUNet_raw='/projects/0/nwo2021061/uls23/nnUNet_raw'
export nnUNet_preprocessed='/home/ljulius/algorithm/nnunet/nnUNet_preprocessed  '
export nnUNet_results='/home/ljulius/algorithm/nnunet/nnUNet_results'
export OUTPUT_DIR='/home/ljulius/data/output/'
export INPUT_DIR='/home/ljulius/data/input/'
export MAIN_DIR='/home/ljulius/'
export TMP_DIR='/scratch-local/ljulius/'

DATASET_ID=501
now=$(date)
echo "Hello, this is a ULS job training"
echo "The starting time is $now"
echo "This version is with augmentatation and from NOT! a 901 checkpoint"
echo "Training on 2D"
timestr=$(date +"%Y-%m-%d_%H-%M-%S")
source "/home/ljulius/miniconda3/etc/profile.d/conda.sh"
source /home/${USER}/.bashrc
conda activate uls
export nnUNet_raw="/projects/0/nwo2021061/uls23/nnUNet_raw"
export nnUNet_preprocessed="/home/ljulius/algorithm/nnunet/nnUNet_preprocessed  "
export nnUNet_results="/home/ljulius/algorithm/nnunet/nnUNet_results"
export OUTPUT_DIR="/home/ljulius/data/output/"
export INPUT_DIR="/home/ljulius/data/input/"
export MAIN_DIR="/home/ljulius/"
export TMP_DIR="/scratch-local/ljulius/"
nnUNetv2_train $DATASET_ID 2d 0 -tr nnUNetTrainer_ULS_50_HalfLR -pretrained_weights algorithm/nnunet/nnUNet_results/Dataset901_Filtered_FSUP/nnUNetTrainer_ULS_500_QuarterLR__nnUNetPlansNoRs__3d_fullres_resenc/fold_all/checkpoint_best.pth --val
now2=$(date)
echo "Done at $now"
