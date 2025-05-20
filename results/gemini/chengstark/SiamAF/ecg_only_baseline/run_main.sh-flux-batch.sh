#!/bin/bash
#FLUX: -N1
#FLUX: -t 240h0m0s
#FLUX: --mem-per-node=220G
#FLUX: --gpus-per-node=2
#FLUX: -C volta
#FLUX: -q overflow
#FLUX: -o /home/zguo30/ppg_ecg_proj/ecg_only_baseline/slurm_outputs/%j.out
#FLUX: --job-name=python_main # Optional: give the job a name

source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch

echo "JOB START"
echo "Job ID: $(flux job id)"
echo "Running on nodes: $(flux resource list -N -o '{%.2Nid}')" # Example of getting node info in Flux

nvidia-smi

python main.py