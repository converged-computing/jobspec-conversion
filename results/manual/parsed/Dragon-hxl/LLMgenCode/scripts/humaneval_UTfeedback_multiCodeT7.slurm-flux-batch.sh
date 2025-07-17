#!/bin/bash
#FLUX: --job-name=CODETpT_157
#FLUX: -c=64
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
module load cuda-cudnn/11.7-8.5.0
echo $(module list)              # list modules loaded
echo $(which gcc)
echo $(which python)
echo $(which python3)
cluster-quota                    # nas quota
nvidia-smi --format=csv --query-gpu=name,driver_version,power.limit # gpu info
echo "Use GPU ${CUDA_VISIBLE_DEVICES}"                              # which gpus
nvidia-smi
cd /home/S/hexiaolong/codex/self-debug/src
python3.9 job-record.py -jobID $SLURM_JOBID -comment "use gened testcase for feedback.prompt testcase for passrate." -output_file "../res/UTfeedback_PassRate_mix092_10_7b16k_pT_157.jsonl"
python3.9 humaneval_UTfeedback_multiCodeT7.py +model_path=/lustre/S/hexiaolong/vicuna-7b-16k/ +output=../res/UTfeedback_PassRate_mix092_10_7b16k_pT_157.jsonl
echo "Job end at $(date "+%Y-%m-%d %H:%M:%S")"
