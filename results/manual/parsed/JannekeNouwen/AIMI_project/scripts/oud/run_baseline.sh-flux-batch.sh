#!/bin/bash
#FLUX: --job-name=quirky-fork-7650
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export nnUNet_raw='/home/ljulius/algorithm/nnunet/nnUNet_raw'
export nnUNet_preprocessed='/home/ljulius/algorithm/nnunet/nnUNet_preprocessed'
export nnUNet_results='/home/ljulius/algorithm/nnunet/nnUNet_results'
export OUTPUT_DIR='/home/ljulius/data/output/'
export INPUT_DIR='/home/ljulius/data/input/'
export MAIN_DIR='/home/ljulius/'
export TMP_DIR='/scratch-local/ljulius/'

now=$(date)
echo "Hello, this is a ULS job running process.py."
echo "The starting time is $now"
export nnUNet_raw="/home/ljulius/algorithm/nnunet/nnUNet_raw"
export nnUNet_preprocessed="/home/ljulius/algorithm/nnunet/nnUNet_preprocessed"
export nnUNet_results="/home/ljulius/algorithm/nnunet/nnUNet_results"
export OUTPUT_DIR="/home/ljulius/data/output/"
export INPUT_DIR="/home/ljulius/data/input/"
export MAIN_DIR="/home/ljulius/"
export TMP_DIR="/scratch-local/ljulius/"
timestr=$(date +"%Y-%m-%d_%H-%M-%S")
source "/home/ljulius/miniconda3/etc/profile.d/conda.sh"
conda activate uls
python /home/ljulius/repos/AIMI_project/ULS23-main/baseline_model/process.py
now2=$(date)
echo "Done at $now"
