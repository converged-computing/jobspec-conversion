#!/bin/bash
#SBATCH --job-name=gscola13bpy
#SBATCH --output=codellama_gen_solution_13bpy_149.out
#SBATCH --error=codellama_gen_solution_13bpy_149.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:4
#SBATCH --time=1-06:00:00
#SBATCH --partition=r8nv-gpu-hw
#SBATCH --qos=gpu-normal
#SBATCH --constraint=80G
#SBATCH --nodelist=r8a100-d05

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
cd ~/codex/codellama
torchrun --nproc_per_node 2 codellama_gen_solution.py --ckpt_dir /lustre/S/liuchenxiao/@datasets/llama2/codellama.model/CodeLlama-13b-Python --tokenizer_path /lustre/S/liuchenxiao/@datasets/llama2/codellama.model/CodeLlama-13b-Python/tokenizer.model --max_seq_len 2048 --max_batch_size 16
echo "Job end at $(date "+%Y-%m-%d %H:%M:%S")"
