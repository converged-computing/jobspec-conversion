#!/bin/bash
#FLUX: --job-name=xfbai-QA     #作业名称
#FLUX: --queue=q_intel_share       #选择资源分区
#FLUX: --priority=16

hostname
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
module load Anaconda cuda-11.8 gcc-9.3.0
source /data/anaconda3/bin/activate
conda activate py3.10torch2.0devel
cd $SLURM_SUBMIT_DIR
bash finetune_qa_clm_lora.sh
