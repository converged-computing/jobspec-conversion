#!/bin/bash

#FLUX: --job-name=python_main_job # Optional: give the job a name
#FLUX: -N 1                       # Number of nodes
#FLUX: -n 1                       # Total number of tasks (processes)
#FLUX: --gpus-per-task=1          # Number of GPUs per task
#FLUX: --requires=mem>=200G       # Memory requirement for the allocated resource (node in this case)
#FLUX: -t 240h                    # Walltime (Flux supports 'h' for hours, 'm' for minutes, 's' for seconds)
#FLUX: -q overflow                # Queue or partition name
#FLUX: --output=/home/zguo30/ppg_ecg_proj/proposed/slurm_outputs/%j.out # Output file, %j is job ID

# Environment setup
# Ensure the paths are correct and accessible in the Flux execution environment
source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch

echo "JOB START"
echo "Job ID: $(flux job id)"
echo "Running on nodes: $FLUX_JOB_NODELIST"

# Verify GPU allocation (original script included this)
nvidia-smi

# Main application
python main.py

echo "JOB END"