#!/bin/bash
#FLUX: --job-name=xfbai-Conparsing     #作业名称
#FLUX: --queue=q_intel_share       #选择资源分区
#FLUX: --priority=16

hostname
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
module load Anaconda cuda-11.7 gcc-9.3.0
source activate py3.10torch2.0
cd $SLURM_SUBMIT_DIR
echo ${SLURM_SUBMIT_DIR}
bash xxx.sh				#执行用户程序
