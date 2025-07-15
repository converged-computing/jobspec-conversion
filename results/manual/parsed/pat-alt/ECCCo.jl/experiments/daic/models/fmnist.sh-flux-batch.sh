#!/bin/bash
#FLUX: --job-name="Train Fashion MNIST (ECCCo)"
#FLUX: --gpus-per-task=1
#FLUX: --queue=general
#FLUX: -t=10800
#FLUX: --priority=16

srun julia --project=experiments experiments/run_experiments.jl -- data=fmnist output_path=results only_models > experiments/train_fmnist.log
