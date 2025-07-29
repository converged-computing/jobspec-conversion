#!/bin/bash
#SBATCH --job-name=res17
#SBATCH --account=scavenger
#SBATCH --output=cmllogs/%x_%j.log
#SBATCH --error=cmllogs/%x_%j.log
#SBATCH --mail-user=arjung15@umd.edu
#SBATCH --mail-type=END,TIME_LIMIT,FAIL,ARRAY_TASKS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=16gb
#SBATCH --time=10:00:00
#SBATCH --partition=scavenger
#SBATCH --qos=scavenger

python generate_poison.py cfg_CIFAR/singlesource_singletarget_binary_finetune_3/experiment_0017.cfg &&
python finetune_and_test.py cfg_CIFAR/singlesource_singletarget_binary_finetune_3/experiment_0017.cfg
