#!/bin/bash
#FLUX: --job-name=stanky-kerfuffle-1186
#FLUX: -c=64
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
python3.9 job-record.py -jobID $SLURM_JOBID -comment "new version code. tree search with testcase filter SBSP10. seed 2024." -output_file "../res/TF_SBSP10_7b16k_pT.jsonl"
python3.9 main.py +model_path=/lustre/S/hexiaolong/vicuna-7b-16k/ +output=../res/TF_SBSP10_7b16k_pT.jsonl +sample_num=10 +Strategy=TFTS +dataset=humaneval
sleep 12h
echo "Job end at $(date "+%Y-%m-%d %H:%M:%S")"
