#!/bin/bash
#FLUX: --job-name=moolicious-parrot-9128
#FLUX: --queue=gpu
#FLUX: -t=432000
#FLUX: --urgency=16

export NCCL_P2P_DISABLE='1'

export NCCL_P2P_DISABLE=1
source ~/.bashrc
conda activate rnn_env
optimization_steps=100
experiment=logs/overfitting_K=0.1
for i in $(seq $optimization_steps)
do
    echo
    echo "-----------------------------"
    echo "Optimization step: $i / $optimization_steps"
    echo
    echo "Making gridsearch step."
    python gridsearch.py --experiment_path $experiment
    echo "Running trainer."
    srun python trainer.py --num_nodes 1 --devices 0 --train_size 1.0 --epochs 4000 --experiment_path $experiment
    echo "Updating parameter intervals."
    python update.py --min_good_samples 4 --max_good_loss 1e-6 --check_every_n_steps 3 --current_step $i --experiment_path $experiment
done
echo
echo "-----------------------------"
echo "Optimization finished."
