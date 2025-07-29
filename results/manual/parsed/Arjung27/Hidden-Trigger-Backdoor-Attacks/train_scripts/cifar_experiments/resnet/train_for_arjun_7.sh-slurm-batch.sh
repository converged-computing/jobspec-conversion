#!/bin/bash
#SBATCH --job-name=res7
#SBATCH --account=scavenger
#SBATCH --output=cmllogs/%x_%A_%a.log
#SBATCH --error=cmllogs/%x_%A_%a.log
#SBATCH --mail-user=arjung15@umd.edu
#SBATCH --mail-type=END,TIME_LIMIT,FAIL,ARRAY_TASKS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=16gb
#SBATCH --time=1-00:00:00
#SBATCH --partition=scavenger
#SBATCH --qos=scavenger
#SBATCH --array=1

CUDA_VISIBLE_DEVICES=0 python generate_poison.py cfg_CIFAR/singlesource_singletarget_binary_finetune/experiment_0017.cfg &&
CUDA_VISIBLE_DEVICES=0 python finetune_and_test.py cfg_CIFAR/singlesource_singletarget_binary_finetune/experiment_0017.cfg
