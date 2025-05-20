#!/bin/bash
#FLUX: --job-name=python_main_job  # Optional: give the job a name
#FLUX: --walltime=240:00:00        # time requested in HH:MM:SS
#FLUX: --tasks-per-node=1          # Request 1 task per node
#FLUX: --nodes=1                   # Request 1 node
#FLUX: --gpus-per-task=1           # Request 1 GPU for the task
#FLUX: --memory-per-task=230G      # Request 230GB memory for the task
#FLUX: --queue=overflow            # Specify the queue/partition
#FLUX: --output=/home/zguo30/ppg_ecg_proj/ecg_only_baseline_limited_labeled/slurm_outputs/%J.out
#FLUX: --error=/home/zguo30/ppg_ecg_proj/ecg_only_baseline_limited_labeled/slurm_outputs/%J.err # Optional: specify error file

# Environment setup
source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch

echo "JOB START"
echo "Flux Job ID: $FLUX_JOB_ID"
echo "Running on host: $(hostname)"
echo "Allocated GPUs: $CUDA_VISIBLE_DEVICES" # Flux usually sets this

# Verify GPU allocation (optional, but good practice)
nvidia-smi

# Execute the main application
python main.py

echo "JOB END"