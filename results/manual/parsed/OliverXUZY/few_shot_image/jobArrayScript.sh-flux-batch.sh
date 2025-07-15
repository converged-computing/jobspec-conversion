#!/bin/bash
#FLUX: --job-name=bricky-fudge-3502
#FLUX: -c=12
#FLUX: --urgency=16

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
