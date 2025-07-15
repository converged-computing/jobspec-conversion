#!/bin/bash
#FLUX: --job-name="Train German Credit (ECCCo)"
#FLUX: --gpus-per-task=1
#FLUX: --queue=general
#FLUX: -t=3600
#FLUX: --priority=16

srun julia --project=experiments experiments/run_experiments.jl -- data=german_credit output_path=results only_models > experiments/train_german_credit.log
