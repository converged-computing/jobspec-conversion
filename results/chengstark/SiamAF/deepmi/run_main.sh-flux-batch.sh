#!/bin/bash
# flux: --job-name=python_deepmi_job
# flux: --walltime=240h
# flux: --queue=overflow
# flux: -N 1
# flux: -n 1
# flux: --gpus=2
# flux: --mem-per-task=240G
# flux: --output=/home/zguo30/ppg_ecg_proj/deepmi/slurm_outputs/flux_%j.out
# flux: --error=/home/zguo30/ppg_ecg_proj/deepmi/slurm_outputs/flux_%j.out

# Environment setup
source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch

echo "JOB START - Flux Job ID: $FLUX_JOB_ID"
echo "Running on host: $(hostname)"
echo "Allocated GPUs: $CUDA_VISIBLE_DEVICES" # Flux usually sets this

# Diagnostic command (optional, but good practice)
echo "Running nvidia-smi:"
nvidia-smi

# Main application
echo "Executing python main.py"
python main.py

echo "JOB END"