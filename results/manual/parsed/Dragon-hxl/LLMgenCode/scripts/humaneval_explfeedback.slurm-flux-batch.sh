#!/bin/bash
#FLUX: --job-name=expl7b16k
#FLUX: -c=32
#FLUX: --queue=r8nv-gpu-hw
#FLUX: -t=108000
#FLUX: --urgency=16

echo "Job start at $(date "+%Y-%m-%d %H:%M:%S")"
echo "Job run at:"
echo "$(hostnamectl)"
source /tools/module_env.sh
module list                       # list modules loaded
module load cluster-tools/v1.0
module load slurm-tools/v1.0
module load cmake/3.21.7
module load python3/3.8.16
module load cuda-cudnn/11.6-8.4.1
echo $(module list)              # list modules loaded
echo $(which gcc)
echo $(which python)
echo $(which python3)
cluster-quota                    # nas quota
nvidia-smi --format=csv --query-gpu=name,driver_version,power.limit # gpu info
echo "Use GPU ${CUDA_VISIBLE_DEVICES}"                              # which gpus
cd ~/codex/human-eval
python3.9 humaneval_explfeedback.py -mf /lustre/S/hexiaolong/vicuna-7b-16k/ -o explfeedback_7b16k.jsonl
echo "Job end at $(date "+%Y-%m-%d %H:%M:%S")"
