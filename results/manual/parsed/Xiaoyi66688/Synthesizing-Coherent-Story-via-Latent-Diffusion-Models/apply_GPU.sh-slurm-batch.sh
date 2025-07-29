#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=ret-%j.out
#SBATCH --error=ret-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=08:00:00
#SBATCH --qos=gpu-short
#SBATCH --constraint=A100
#SBATCH --nodelist=r8a100-c01

echo "Job start at $(date "+%Y-%m-%d %H:%M:%S")"
echo "Job run at:"
echo "$(hostnamectl)"
echo "$(df -h | grep -v tmpfs)"
source /tools/module_env.sh
module list                       # list modules loaded
module load cluster-tools/v1.0
module load slurm-tools/v1.0
module load python3/3.8.16
module load cuda-cudnn/11.6-8.4.1
echo $(module list)              # list modules loaded
echo $(which gcc)
echo $(which python)
echo $(which python3)
cluster-quota                    # nas quota
nvidia-smi --format=csv --query-gpu=name,driver_version,power.limit # gpu info
echo "Use GPU ${CUDA_VISIBLE_DEVICES}"                              # which gpus
sleep 99999
echo "Job end at $(date "+%Y-%m-%d %H:%M:%S")"
