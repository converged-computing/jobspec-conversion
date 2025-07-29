#!/bin/bash
#SBATCH --job-name=SBP10_164
#SBATCH --output=../log/humaneval_UTfeedback_multiSBP10_7b16k_tT_164.out
#SBATCH --error=../log/humaneval_UTfeedback_multiSBP10_7b16k_tT_164.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:4
#SBATCH --time=1-06:00:00
#SBATCH --partition=r8nv-gpu-hw
#SBATCH --qos=gpu-normal
#SBATCH --constraint=80G

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
cd /home/S/hexiaolong/codex/self-debug/src
python3.9 humaneval_UTfeedback_multi.py +model_path=/lustre/S/hexiaolong/vicuna-7b-16k/ +output=../res/UTfeedback_multiSBP10_7b16k_tT_164.jsonl
echo "Job end at $(date "+%Y-%m-%d %H:%M:%S")"
