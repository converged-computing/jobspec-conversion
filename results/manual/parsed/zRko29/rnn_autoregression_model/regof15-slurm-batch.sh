#!/bin/bash
#SBATCH --output=slurm.%N.%j.out
#SBATCH --error=slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=24G
#SBATCH --time=5-00:00:00
#SBATCH --partition=gpu
#SBATCH --qos=valhala
#SBATCH --constraint=ntasks-per-node=1

export NCCL_P2P_DISABLE='1'

export NCCL_P2P_DISABLE=1
source ~/.bashrc
conda activate rnn_env
optimization_steps=100
experiment=logs/overfitting_K=1.5
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
