#!/bin/bash
#FLUX: --job-name=xfbai-Conparsing
#FLUX: --queue=q_intel_share
#FLUX: --urgency=16

hostname
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
module load Anaconda cuda-11.8 gcc-9.3.0
source activate py3.10torch2.0devel
cd $SLURM_SUBMIT_DIR
bash finetune_conparsing_clm_13B.sh
