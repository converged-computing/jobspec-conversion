#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=24G
#SBATCH --time=6-00:00:00

echo "Starting $1 parallel processes on a single GPU"
for i in $(seq 1 $1); do
    PYTHONPATH="$PYTHONPATH:$(pwd)" python3.6 -u "$2" "$SLURM_ARRAY_TASK_ID" &
    pids[$i]=$!
done
for pid in ${pids[*]}; do
    wait $pid
done
