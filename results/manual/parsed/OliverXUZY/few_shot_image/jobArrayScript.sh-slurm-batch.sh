#!/bin/bash
#SBATCH --job-name=vary_num
#SBATCH --output=./log/python_array_job_slurm_%A_%a.out
#SBATCH --error=./log/python_array_job_slurm_%A_%a.err
#SBATCH --mail-user=zxu444@wisc.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:2
#SBATCH --mem=40GB
#SBATCH --time=10-16:00:00
#SBATCH --partition=lianglab
#SBATCH --constraint=ntasks-per-node=1

source ~/.bashrc
(
    while true; do
        nvidia-smi >> ./log/gpu/gpu_usage_${SLURM_JOB_ID}.log
        sleep 60  # Log every 60 seconds
    done
) &
monitor_pid=$!
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
echo "======== testing CUDA available ========"
python - << EOF
import torch
print(torch.cuda.is_available())
print(torch.cuda.device_count())
print(torch.cuda.current_device())
print(torch.cuda.device(0))
print(torch.cuda.get_device_name(0))
EOF
echo "======== run with different inputs ========"
echo $( awk "NR==$SLURM_ARRAY_TASK_ID" input_path_list.txt )
python test.py \
    --config $( awk "NR==$SLURM_ARRAY_TASK_ID" input_files_jobarray/input_maml_test_configs.txt ) \
    --save_path $( awk "NR==$SLURM_ARRAY_TASK_ID" input_files_jobarray/input_maml_test_loadpath.txt ) \
kill $monitor_pid
