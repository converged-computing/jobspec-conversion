#!/bin/bash
#FLUX: --job-name="Train Tabular (ECCCo)"
#FLUX: --gpus-per-task=1
#FLUX: --queue=general
#FLUX: -t=18000
#FLUX: --priority=16

module use /opt/insy/modulefiles          # Use DAIC INSY software collection
module load openmpi
srun julia --project=experiments experiments/run_experiments.jl -- data=gmsc,german_credit,california_housing output_path=results only_models > experiments/train_tabular.log
