#!/bin/bash
#SBATCH --job-name=symSynTopologyTrain
#SBATCH --output=tf-logs/slurm/topology-train-%A_%a.out
#SBATCH --error=tf-logs/slurm/topology-train-%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=12gb
#SBATCH --partition=gpu-ms
#SBATCH --array=0-7
#SBATCH --exclude=dll-3gpu[1-5],dll-4gpu[1-4],dll-8gpu[1-6],dll-10gpu1

export LD_LIBRARY_PATH='/opt/cuda/9.0/lib64:/opt/cuda/9.0/cudnn/7.0/lib64'

ID_TO_NAME="
A
B
C
D
E
F
G
H
"
NAME=$(echo "$ID_TO_NAME" | head -n $(expr 2 + $SLURM_ARRAY_TASK_ID) | tail -n 1)
SEED=$1
if [ -z "$SEED" ]; then
    echo "Seed argument missing"
    exit 1
fi
echo "################################"
echo "# Topology train ${NAME}_${SEED}"
echo "################################"
echo
export LD_LIBRARY_PATH=/opt/cuda/9.0/lib64:/opt/cuda/9.0/cudnn/7.0/lib64
.venv/bin/python3 experiment_symbols.py train \
    --model experiment_${NAME}_${SEED} \
    --symbols datasets/experiments/${NAME}_${SEED} \
    --seed_offset $SEED
echo
echo "########"
echo "# DONE #"
echo "########"
