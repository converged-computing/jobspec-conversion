#!/bin/bash
#FLUX: --job-name="Tune Fashion MNIST Model (ECCCo)"
#FLUX: --gpus-per-task=1
#FLUX: --queue=general
#FLUX: -t=18000
#FLUX: --priority=16

srun julia --project=experiments experiments/run_experiments.jl -- data=fmnist output_path=results tune_model
