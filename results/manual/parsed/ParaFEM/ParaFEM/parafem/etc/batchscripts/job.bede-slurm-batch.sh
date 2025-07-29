#!/bin/bash
#SBATCH --account=<ACCOUNTID>
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:05:00

nvidia-smi
bede-mpirun --bede-par 1ppg -np 1 ~/parafem/parafem/bin/xx3 xx3_small
