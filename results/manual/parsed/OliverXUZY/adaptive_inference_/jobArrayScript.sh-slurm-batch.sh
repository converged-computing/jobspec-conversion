#!/bin/bash
#SBATCH --job-name=eval_res50
#SBATCH --output=./eulerlog/res50_job_slurm_%A_%a.out
#SBATCH --error=./eulerlog/res50_job_slurm_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=40GB
#SBATCH --time=10-16:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --exclude=euler[01-09],euler[11-12],euler[14],euler[24-27]

source ~/.bashrc
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
echo "======== testing CUDA available ========"
echo "running on machine: " $(hostname -s)
python - << EOF
import torch
print(torch.cuda.is_available())
print(torch.cuda.device_count())
print(torch.cuda.current_device())
print(torch.cuda.device(0))
print(torch.cuda.get_device_name(0))
EOF
echo "======== run with different inputs ========"
python eval_constrain_macs.py \
    --load_path './log/train_resnet50_imagenet' \
    --limit 5000 \
    --skip_block $( awk "NR==$SLURM_ARRAY_TASK_ID" input_files_jobarray/input_file_skip_block.txt )
