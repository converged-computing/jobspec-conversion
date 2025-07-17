#!/bin/bash
#FLUX: --job-name=grated-squidward-6056
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export nnUNet_raw='/projects/0/nwo2021061/uls23/nnUNet_raw'
export nnUNet_preprocessed='/home/ljulius/algorithm/nnunet/nnUNet_preprocessed'
export nnUNet_results='/home/ljulius/algorithm/nnunet/nnUNet_results'

DATASET_ID=501
now=$(date)
echo "Hello, this is a ULS job running preprocessing."
echo "The starting time is $now"
timestr=$(date +"%Y-%m-%d_%H-%M-%S")
source "/home/ljulius/miniconda3/etc/profile.d/conda.sh"
source /home/${USER}/.bashrc
conda activate uls
export nnUNet_raw="/projects/0/nwo2021061/uls23/nnUNet_raw"
export nnUNet_preprocessed="/home/ljulius/algorithm/nnunet/nnUNet_preprocessed"
export nnUNet_results="/home/ljulius/algorithm/nnunet/nnUNet_results"
nnUNetv2_plan_and_preprocess -d 501 --verify_dataset_integrity -pl nnUNetPlansNoRs
now2=$(date)
echo "Done at $now"
