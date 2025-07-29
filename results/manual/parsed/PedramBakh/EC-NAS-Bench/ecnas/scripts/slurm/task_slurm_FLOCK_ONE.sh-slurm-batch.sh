#!/bin/bash
#SBATCH --job-name=ec_first
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=8000M
#SBATCH --time=10:00:00
#SBATCH --partition=gpu
#SBATCH --array=0-7
#SBATCH --exclude=a00610,a00621,a00636,a00637,a00701,a00818,a00861,a00862,a00863,a00885,a00886,a00756,a00757,a00860,

hostname
echo $CUDA_VISIBLE_DEVICES
wid=$((SLURM_ARRAY_TASK_ID))
sleep $((30))
parentdir="${PWD%/*}"
$parentdir/scripts/train_models.sh --vertices=5 --edges=9 --epochs=108 --graph_file="5V9E_sample_700" --workers=16 --worker_id=$wid --worker_offset=0 --verbose
