#!/bin/bash
#SBATCH --job-name=try
#SBATCH --output=../log/try.out
#SBATCH --error=../log/try.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=1-06:00:00
#SBATCH --partition=r8nv-gpu
#SBATCH --qos=gpu-normal
#SBATCH --constraint=24G

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
cd /home/S/hexiaolong/codex/self-debug/tools
python3.9 try.py --model_path /lustre/S/hexiaolong/vicuna-7b-16k/ --output_file try.jsonl
echo "Job end at $(date "+%Y-%m-%d %H:%M:%S")"
