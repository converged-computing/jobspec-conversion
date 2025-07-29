#!/bin/bash
#SBATCH --job-name=mix10_153
#SBATCH --output=../log/humaneval_UTfeedback_PassRate_mix10_10_7b16k_pT_153.out
#SBATCH --error=../log/humaneval_UTfeedback_PassRate_mix10_10_7b16k_pT_153.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --gres=gpu:4
#SBATCH --time=1-06:00:00
#SBATCH --partition=r8nv-gpu-hw
#SBATCH --qos=gpu-normal
#SBATCH --constraint=80G
#SBATCH --nodelist=r8a100-c01

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
python3.9 job-record.py -jobID $SLURM_JOBID -comment "use gened testcase for feedback with 100 percent correctness.prompt testcase for passrate." -output_file "../res/UTfeedback_PassRate_mix10_10_7b16k_pT_153.jsonl"
python3.9 humaneval_UTfeedback_multiCodeT9.py +model_path=/lustre/S/hexiaolong/vicuna-7b-16k/ +output=../res/UTfeedback_PassRate_mix10_10_7b16k_pT_153.jsonl
echo "Job end at $(date "+%Y-%m-%d %H:%M:%S")"
