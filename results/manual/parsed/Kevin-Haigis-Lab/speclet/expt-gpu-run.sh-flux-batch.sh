#!/bin/bash
#FLUX: --job-name=expt-gpu
#FLUX: --queue=gpu_quad
#FLUX: -t=10
#FLUX: --urgency=16

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
