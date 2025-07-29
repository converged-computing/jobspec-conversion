#!/bin/bash
#SBATCH --job-name=expt-gpu
#SBATCH --account=park
#SBATCH --output=logs/%j_expt-gpu.log
#SBATCH --error=logs/%j_expt-gpu.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --mem=16G
#SBATCH --time=00:00:10
#SBATCH --partition=gpu_quad

module load conda2
source "$HOME/.bashrc"
conda activate speclet
which nvidia-smi
which nvcc
nvidia-smi
nvcc --version
/n/cluster/bin/job_gpu_monitor.sh & ./speclet/cli/fit_bayesian_model_cli.py \
    "hnb-single-lineage-prostate" \
    models/model-configs.yaml \
    "PYMC_NUMPYRO" \
    temp/gpu-expt/ \
    --mcmc-chains 1 \
    --mcmc-cores 1 \
    --seed 123 \
    --broad-only
exit 23
