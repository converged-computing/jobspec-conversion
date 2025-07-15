#!/bin/bash
#FLUX: --job-name="Train MNIST (ECCCo)"
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=10800
#FLUX: --priority=16

srun julia --project=experiments experiments/run_experiments.jl -- data=mnist output_path=results only_models > experiments/train_mnist.log
